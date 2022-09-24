import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_droidkaigi_2022/src/model/msg_battery_state.dart';
import 'package:flutter_droidkaigi_2022/src/model/msg_temperature.dart';
import 'package:flutter_droidkaigi_2022/src/screen/monitor/monitor_home_page.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:roslibdart/roslibdart.dart';

class RealMonitorPage extends StatefulWidget {
  const RealMonitorPage({Key? key}) : super(key: key);

  @override
  State<RealMonitorPage> createState() => _RealMonitorPageState();
}

class _RealMonitorPageState extends State<RealMonitorPage> {
  Timer? pTimer;
  Timer? angelTimer;
  List<FlSpot> temperatureItems = [];
  List<FlSpot> cpuTemperatureItems = [];
  List<FlSpot> gpuTemperatureItems = [];
  List<FlSpot> batteryItems = [];
  List<FlSpot> batteryCurrentItems = [];
  List<FlSpot> sineItems = [];
  List<double> rawSineItems = [];
  List<FlSpot> cosItems = [];
  List<double> rawCosItems = [];
  double chartXIndex = 0.0;

  double chartAngelXIndex = 0.0;
  int angelIndex = 0;

  TextEditingController ipTextController = TextEditingController();
  TextEditingController portTextController = TextEditingController(text: "9090");

  late Ros ros;
  late Topic chatter;
  late Topic temperatureTopic;
  late Topic cpuTemperatureTopic;
  late Topic gpuTemperatureTopic;
  late Topic batteryTopic;
  String msgReceived = '';

  Future initRos() async {
    // ros = Ros(url: 'ws://127.0.0.1:9090');
    if (ipTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ip 情報を入力してください。"),
        ),
      );
      return;
    }
    if (portTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("port 情報を入力してください。"),
        ),
      );
      return;
    }
    ros = Ros(url: 'ws://${ipTextController.text.trim()}:${portTextController.text.trim()}');
    chatter = Topic(
      ros: ros,
      name: '/topic',
      type: "std_msgs/String",
      reconnectOnClose: true,
      queueLength: 10,
      queueSize: 10,
    );

    batteryTopic = Topic(
      ros: ros,
      name: '/topic/battery',
      type: "sensor_msgs/BatteryState",
      reconnectOnClose: true,
      queueLength: 10,
      queueSize: 10,
    );

    cpuTemperatureTopic = Topic(
      ros: ros,
      name: '/topic/cpu_temp',
      type: "sensor_msgs/Temperature",
      reconnectOnClose: true,
      queueLength: 10,
      queueSize: 10,
    );

    ros.connect();
  }

  Future connect() async {
    initRos();
    Timer(const Duration(seconds: 3), () async {
      await chatter.subscribe(subscribeHandler);
      await batteryTopic.subscribe(subscribeBatteryStateHandler);
      await cpuTemperatureTopic.subscribe(subscribeCpuTempHandler);
    });
  }

  Future<void> subscribeHandler(Map<String, dynamic> msg) async {
    msgReceived = json.encode(msg);
    print("subscribeHandler: $msgReceived");
    setState(() {});
  }

  Future<void> subscribeCpuTempHandler(Map<String, dynamic> msg) async {
    msgReceived = json.encode(msg);
    print("subscribeCpuTempHandler: $msgReceived");
    MsgTemperature msgTemperature = MsgTemperature.fromJson(msg);
    cpuTemperatureItems.add(FlSpot(chartXIndex, msgTemperature.temperature));
    chartXIndex++;
    if (cpuTemperatureItems.length > 15) {
      cpuTemperatureItems.removeAt(0);
    }
    setState(() {});
  }

  double chartBatteryXIndex = 0;

  Future<void> subscribeBatteryStateHandler(Map<String, dynamic> msg) async {
    msgReceived = json.encode(msg);
    // print("msgReceived: $msgReceived");
    MsgBatteryState msgBatteryState = MsgBatteryState.fromJson(msg);
    print("voltage: ${msgBatteryState.voltage} ");
    batteryItems.add(FlSpot(chartBatteryXIndex, msgBatteryState.voltage));
    batteryCurrentItems.add(FlSpot(chartBatteryXIndex, msgBatteryState.current));
    chartBatteryXIndex++;
    if (batteryItems.length > 15) {
      batteryItems.removeAt(0);
    }
    setState(() {});
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await batteryTopic.unsubscribe();
    await cpuTemperatureTopic.unsubscribe();
    await ros.close();
    chartBatteryXIndex = 0;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    destroyConnection();
    cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future start() async {
    for (int i = 0; i < 360; i++) {
      rawSineItems.add(sin((i / 180) * pi));
      rawCosItems.add(cos((i / 180) * pi));
    }
    // pTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
    //   temperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 35.1)));
    //   cpuTemperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 40.1)));
    //   gpuTemperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 60.1)));
    //   batteryItems.add(FlSpot(chartXIndex, ((Random().nextDouble() + 98.0))));
    //   chartXIndex++;
    //   // print(temperatureItems);
    //   if (temperatureItems.length > 15) {
    //     temperatureItems.removeAt(0);
    //     cpuTemperatureItems.removeAt(0);
    //     gpuTemperatureItems.removeAt(0);
    //   }
    //   setState(() {});
    // });
    //1/60  = 0.167
    angelTimer ??= Timer.periodic(const Duration(milliseconds: 16), (timer) {
      sineItems.add(FlSpot(chartAngelXIndex, rawSineItems[angelIndex]));
      cosItems.add(FlSpot(chartAngelXIndex, rawCosItems[angelIndex]));
      chartAngelXIndex++;
      angelIndex++;

      if (angelIndex >= rawSineItems.length) {
        angelIndex = 0;
      }
      if (sineItems.length > 45) {
        sineItems.removeAt(0);
        cosItems.removeAt(0);
      }
      setState(() {});
    });
  }

  Future cancel() async {
    temperatureItems.clear();
    cpuTemperatureItems.clear();
    gpuTemperatureItems.clear();
    pTimer?.cancel();
    pTimer = null;
    angelTimer?.cancel();
    angelTimer = null;
    chartXIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ipTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      MyInputFormatters.ipAddressInputFilter(),
                      LengthLimitingTextInputFormatter(15),
                      IpAddressInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: "IP",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: TextField(
                  controller: portTextController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Port",
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () async {
                    start();
                    await connect();
                  },
                  child: const Text("接続"),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () async {
                    cancel();
                    destroyConnection();
                  },
                  child: const Text("接続解除"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Temperature",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 60,
                                minY: 30,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: temperatureItems.map((e) => e).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${temperatureItems.isNotEmpty ? temperatureItems.last.y.toStringAsFixed(1) : "??"} C",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: PrettyGauge(
                        gaugeSize: 200,
                        maxValue: 110,
                        minValue: 0,
                        segments: [
                          GaugeSegment('Low', 10, Colors.red),
                          GaugeSegment('Medium', 40, Colors.orange),
                          GaugeSegment('High', 60, Colors.green),
                        ],
                        currentValue: temperatureItems.isNotEmpty ? temperatureItems.last.y : 0,
                        displayWidget: const Text(
                          'Temperature',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text(
            "CPU",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 60,
                                minY: 30,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      isCurved: true,
                                      spots: cpuTemperatureItems.map((e) => e).toList(),
                                      color: Colors.orange),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${cpuTemperatureItems.isNotEmpty ? cpuTemperatureItems.last.y.toStringAsFixed(1) : "??"} C",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: PrettyGauge(
                        gaugeSize: 200,
                        maxValue: 110,
                        minValue: 0,
                        segments: [
                          GaugeSegment('Low', 10, Colors.red),
                          GaugeSegment('Medium', 40, Colors.orange),
                          GaugeSegment('High', 60, Colors.green),
                        ],
                        currentValue: cpuTemperatureItems.isNotEmpty ? cpuTemperatureItems.last.y : 0,
                        displayWidget: const Text(
                          'Temperature',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text(
            "GPU",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 90,
                                minY: 60,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      isCurved: true,
                                      spots: gpuTemperatureItems.map((e) => e).toList(),
                                      color: Colors.purple),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${gpuTemperatureItems.isNotEmpty ? gpuTemperatureItems.last.y.toStringAsFixed(1) : "??"} C",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: PrettyGauge(
                        gaugeSize: 200,
                        maxValue: 110,
                        minValue: 0,
                        segments: [
                          GaugeSegment('Low', 10, Colors.red),
                          GaugeSegment('Medium', 40, Colors.orange),
                          GaugeSegment('High', 60, Colors.green),
                        ],
                        currentValue: gpuTemperatureItems.isNotEmpty ? gpuTemperatureItems.last.y : 0,
                        displayWidget: const Text(
                          'Temperature',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text(
            "Battery",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 100,
                                minY: 10,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      isCurved: true, spots: batteryItems.map((e) => e).toList(), color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${batteryItems.isNotEmpty ? batteryItems.last.y.toStringAsFixed(1) : "??"} %",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Battery Current
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 5,
                                minY: 0,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: batteryCurrentItems.map((e) => e).toList(),
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${batteryCurrentItems.isNotEmpty ? batteryCurrentItems.last.y.toStringAsFixed(1) : "??"} A",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   height: 200,
                  //   child: Card(
                  //     child: PrettyGauge(
                  //       gaugeSize: 200,
                  //       maxValue: 110,
                  //       minValue: 0,
                  //       segments: [
                  //         GaugeSegment('Low', 10, Colors.red),
                  //         GaugeSegment('Medium', 40, Colors.orange),
                  //         GaugeSegment('High', 60, Colors.green),
                  //       ],
                  //       currentValue: gpuTemperatureItems.isNotEmpty ? gpuTemperatureItems.last.y : 0,
                  //       displayWidget: const Text(
                  //         'Temperature',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          const Text(
            "Arm Angel",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 1.0,
                                minY: -1.0,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                      isCurved: true, spots: sineItems.map((e) => e).toList(), color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Text(
                              "${sineItems.isNotEmpty ? sineItems.last.y.toStringAsFixed(1) : "??"}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 1.0,
                                minY: -1.0,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: cosItems.map((e) => e).toList(),
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 800,
                    height: 200,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            top: 8,
                            child: LineChart(
                              LineChartData(
                                maxY: 1.0,
                                minY: -1.0,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: sineItems.map((e) => e).toList(),
                                    color: Colors.red,
                                  ),
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: cosItems.map((e) => e).toList(),
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   height: 200,
                  //   child: Card(
                  //     child: PrettyGauge(
                  //       gaugeSize: 200,
                  //       maxValue: 110,
                  //       minValue: 0,
                  //       segments: [
                  //         GaugeSegment('Low', 10, Colors.red),
                  //         GaugeSegment('Medium', 40, Colors.orange),
                  //         GaugeSegment('High', 60, Colors.green),
                  //       ],
                  //       currentValue: gpuTemperatureItems.isNotEmpty ? gpuTemperatureItems.last.y : 0,
                  //       displayWidget: const Text(
                  //         'Temperature',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
