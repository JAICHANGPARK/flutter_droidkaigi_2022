import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/robotics_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/ros2_foxy_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/ros2_general_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/ros2_humble_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/ros2_iron_page.dart';

class Ros2HomePage extends StatefulWidget {
  const Ros2HomePage({Key? key}) : super(key: key);

  @override
  State<Ros2HomePage> createState() => _Ros2HomePageState();
}

class _Ros2HomePageState extends State<Ros2HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            isScrollable: true,
            tabs: const [
              Tab(
                text: "Robotics",
              ),
              Tab(
                text: "Basic",
              ),
              Tab(
                text: "foxy",
              ),
              Tab(
                text: "humble",
              ),
              Tab(
                text: "Iron",
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                RoboticsPage(),
                Ros2GeneralPage(),
                Ros2FoxyPage(),
                Ros2HumblePage(),
                Ros2IronPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
