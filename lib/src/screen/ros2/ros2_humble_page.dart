import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Ros2HumblePage extends StatefulWidget {
  const Ros2HumblePage({Key? key}) : super(key: key);

  @override
  State<Ros2HumblePage> createState() => _Ros2HumblePageState();
}

class _Ros2HumblePageState extends State<Ros2HumblePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            "Humble Hawksbill",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Wrap(
            children: [
              Image.network(
                "https://aws1.discourse-cdn.com/business7/uploads/ros/optimized/2X/e/e2b80a2e45b12a397dbfebddb3abe92a1b4ce921_2_410x500.png",
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Eretmochelys-imbricata-K%C3%A9lonia-2.JPG/1280px-Eretmochelys-imbricata-K%C3%A9lonia-2.JPG",
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ],
          ),
          const Divider(),
          const Text(
            "LinuxまたはUbuntuオペレーティングシステムの使用をお勧めします。",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text("Ubuntu"),
            trailing: Text("22.04"),
          ),
          const Divider(),
          ListTile(
            title: const Text("Installation"),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrl(Uri.parse("https://docs.ros.org/en/humble/Installation.html"));
            },
          ),
        ],
      ),
    );
  }
}
