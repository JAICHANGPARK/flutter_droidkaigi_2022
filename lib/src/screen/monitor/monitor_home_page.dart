import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roslibdart/roslibdart.dart';

class MonitorHomePage extends StatefulWidget {
  const MonitorHomePage({Key? key}) : super(key: key);

  @override
  State<MonitorHomePage> createState() => _MonitorHomePageState();
}

class _MonitorHomePageState extends State<MonitorHomePage> {
  TextEditingController ipTextController = TextEditingController();
  TextEditingController portTextController = TextEditingController(text: "9090");

  late Ros ros;
  late Topic chatter;
  String msgReceived = '';

  Future initRos() async {
    // ros = Ros(url: 'ws://127.0.0.1:9090');
    if (ipTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ip 情報を入力してください。")));
      return;
    }
    if (portTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("port 情報を入力してください。")));
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
    ros.connect();
  }

  Future<void> subscribeHandler(Map<String, dynamic> msg) async {
    msgReceived = json.encode(msg);
    setState(() {});
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await ros.close();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    destroyConnection();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future connect() async {
    initRos();
    Timer(const Duration(seconds: 3), () async {
      await chatter.subscribe(subscribeHandler);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
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
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () async {
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
                      destroyConnection();
                    },
                    child: const Text("接続解除"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyInputFormatters {
  static TextInputFormatter ipAddressInputFilter() {
    return FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  }
}

class IpAddressInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int dotCounter = 0;
    var buffer = StringBuffer();
    String ipField = "";

    for (int i = 0; i < text.length; i++) {
      if (dotCounter < 4) {
        if (text[i] != ".") {
          ipField += text[i];
          if (ipField.length < 3) {
            buffer.write(text[i]);
          } else if (ipField.length == 3) {
            if (int.parse(ipField) <= 255) {
              buffer.write(text[i]);
            } else {
              if (dotCounter < 3) {
                buffer.write(".");
                dotCounter++;
                buffer.write(text[i]);
                ipField = text[i];
              }
            }
          } else if (ipField.length == 4) {
            if (dotCounter < 3) {
              buffer.write(".");
              dotCounter++;
              buffer.write(text[i]);
              ipField = text[i];
            }
          }
        } else {
          if (dotCounter < 3) {
            buffer.write(".");
            dotCounter++;
            ipField = "";
          }
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }
}
