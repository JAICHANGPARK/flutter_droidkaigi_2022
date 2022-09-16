import 'package:flutter/material.dart';

class Ros2FoxyPage extends StatefulWidget {
  const Ros2FoxyPage({Key? key}) : super(key: key);

  @override
  State<Ros2FoxyPage> createState() => _Ros2FoxyPageState();
}

class _Ros2FoxyPageState extends State<Ros2FoxyPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          Image.network(
            "https://aws1.discourse-cdn.com/business7/uploads/ros/original/2X/d/d6fd5322bd2ddc06530d8352fcab20f0bca08c06.png",
            height: MediaQuery.of(context).size.height / 2.5,
          )



        ],
      ),
    );
  }
}
