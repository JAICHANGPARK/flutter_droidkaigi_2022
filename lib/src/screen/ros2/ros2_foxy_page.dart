import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ros2FoxyPage extends StatefulWidget {
  const Ros2FoxyPage({Key? key}) : super(key: key);

  @override
  State<Ros2FoxyPage> createState() => _Ros2FoxyPageState();
}

class _Ros2FoxyPageState extends State<Ros2FoxyPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            "Foxy Fitzroy",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Image.network(
            "https://aws1.discourse-cdn.com/business7/uploads/ros/original/2X/d/d6fd5322bd2ddc06530d8352fcab20f0bca08c06.png",
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          const Text(
            "LinuxまたはUbuntuオペレーティングシステムの使用をお勧めします。",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text("Ubuntu"),
            trailing: Text("20.04"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Installation"),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://docs.ros.org/en/foxy/Installation.html"));
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
