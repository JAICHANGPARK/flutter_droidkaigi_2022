import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ros2GeneralPage extends StatefulWidget {
  const Ros2GeneralPage({Key? key}) : super(key: key);

  @override
  State<Ros2GeneralPage> createState() => _Ros2GeneralPageState();
}

class _Ros2GeneralPageState extends State<Ros2GeneralPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Image.network(
            "https://avatars.githubusercontent.com/u/3979232?s=280&v=4",
            height: 160,
          ),
          Text(
            "General Documents",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ExpansionTile(
            leading: const Icon(Icons.folder_open),
            title: const Text("ROS wiki"),
            children: [
              ListTile(
                title: const Text("ROS wiki - [English]"),
                leading: const Icon(Icons.description),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launchUrl(Uri.parse("https://wiki.ros.org/"));
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("ROS wiki - [Japanese]"),
                leading: const Icon(Icons.description),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launchUrl(Uri.parse("https://wiki.ros.org/ja"));
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("ROS wiki - [Korean]"),
                leading: const Icon(Icons.description),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launchUrl(Uri.parse("https://wiki.ros.org/ja"));
                },
              ),
            ],
          ),
          const Divider(),
          ListTile(
            title: const Text("ROS Documentation"),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://docs.ros.org/"));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("ROS2 Distributions"),
            leading: const Icon(Icons.rocket_launch),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://docs.ros.org/en/humble/Releases.html"));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("ROS Status"),
            leading: const Icon(Icons.monitor_heart),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://status.ros.org/"));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("ROS2 Roadmap"),
            leading: const Icon(Icons.flag),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://docs.ros.org/en/humble/The-ROS2-Project/Roadmap.html"));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("ROS Discourse"),
            leading: const Icon(Icons.chat_rounded),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse(" https://discourse.ros.org/"));
            },
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
          Text(
            "ROS MSG",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ListTile(
            title: const Text("ROS2 common_interfaces"),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://github.com/ros2/common_interfaces"));
            },
          ),
          const Divider(),
          ExpansionTile(
            leading: const Icon(Icons.folder_open),
            title: const Text("Common Interfaces"),
            children: [
              ListTile(
                title: const Text("std_msgs Msg/Srv"),
                leading: const Icon(Icons.data_object),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launchUrl(Uri.parse("http://docs.ros.org/en/noetic/api/std_msgs/html/index-msg.html"));
                },
              ),
              ExpansionTile(
                leading: const Icon(Icons.folder_open),
                title: Text("sensor_msgs"),
                children: [
                  ListTile(
                    title: const Text("BatteryState Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/sensor_msgs/html/msg/BatteryState.html"));
                    },
                  ),
                  ListTile(
                    title: const Text("Imu Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/sensor_msgs/html/msg/Imu.html"));
                    },
                  ),
                  ListTile(
                    title: const Text("JointState Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/sensor_msgs/html/msg/JointState.html"));
                    },
                  ),
                  ListTile(
                    title: const Text("Joy Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/sensor_msgs/html/msg/Joy.html"));
                    },
                  ),
                  ListTile(
                    title: const Text("Temperature Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/sensor_msgs/html/msg/Temperature.html"));
                    },
                  ),
                ],
              ),
              const Divider(),
              ExpansionTile(
                leading: const Icon(Icons.folder_open),
                title: Text("trajectory_msgs"),
                children: [
                  ListTile(
                    title: const Text("JointTrajectory Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(Uri.parse("http://docs.ros.org/en/api/trajectory_msgs/html/msg/JointTrajectory.html"));
                    },
                  ),
                  ListTile(
                    title: const Text("JointTrajectoryPoint Message"),
                    leading: const Icon(Icons.data_object),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      launchUrl(
                          Uri.parse("http://docs.ros.org/en/api/trajectory_msgs/html/msg/JointTrajectoryPoint.html"));
                    },
                  ),
                ],
              )
            ],
          ),
          const Divider(),
          ListTile(
            title: const Text("Awesome Robot Operating System 2 (ROS 2)"),
            subtitle: Text("@fkromer"),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://github.com/fkromer/awesome-ros2"));
            },
          ),
          ListTile(
            title: const Text("ros-robotics-companies"),
            subtitle: Text("@vmayoral"),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://github.com/vmayoral/ros-robotics-companies"));
            },
          ),
        ],
      ),
    );
  }
}
