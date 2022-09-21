import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class FakeMonitorPage extends StatefulWidget {
  const FakeMonitorPage({Key? key}) : super(key: key);

  @override
  State<FakeMonitorPage> createState() => _FakeMonitorPageState();
}

class _FakeMonitorPageState extends State<FakeMonitorPage> {
  Timer? pTimer;
  Timer? angelTimer;
  List<FlSpot> temperatureItems = [];
  List<FlSpot> cpuTemperatureItems = [];
  List<FlSpot> gpuTemperatureItems = [];
  List<FlSpot> batteryItems = [];
  List<FlSpot> sineItems = [];
  List<double> rawSineItems = [];
  List<FlSpot> cosItems = [];
  List<double> rawCosItems = [];
  double chartXIndex = 0.0;

  double chartAngelXIndex = 0.0;
  int angelIndex = 0;

  Future start() async {
    for (int i = 0; i < 360; i++) {
      rawSineItems.add(sin((i / 180) * pi));
      rawCosItems.add(cos((i / 180) * pi));
    }
    pTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      temperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 35.1)));
      cpuTemperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 40.1)));
      gpuTemperatureItems.add(FlSpot(chartXIndex, ((Random().nextDouble() * 10) + 60.1)));
      batteryItems.add(FlSpot(chartXIndex, ((Random().nextDouble() + 98.0))));
      chartXIndex++;
      // print(temperatureItems);
      if (temperatureItems.length > 15) {
        temperatureItems.removeAt(0);
        cpuTemperatureItems.removeAt(0);
        gpuTemperatureItems.removeAt(0);
      }
      setState(() {});
    });
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(
            child: Row(
              children: const [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "IP",
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                    // await connect();
                    start();
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
                    // destroyConnection();
                    cancel();
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
