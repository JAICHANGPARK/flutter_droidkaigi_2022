import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RoboticsPage extends StatefulWidget {
  const RoboticsPage({Key? key}) : super(key: key);

  @override
  State<RoboticsPage> createState() => _RoboticsPageState();
}

class _RoboticsPageState extends State<RoboticsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://github.com/clearpathrobotics/spot_ros"));
              },
              child: Image.network("https://raw.githubusercontent.com/clearpathrobotics/spot_ros/master/cp_spot.jpg")),
        ],
      ),
    );
  }
}
