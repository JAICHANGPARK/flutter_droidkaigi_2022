import 'package:flutter/material.dart';

class Ros2IronPage extends StatefulWidget {
  const Ros2IronPage({Key? key}) : super(key: key);

  @override
  State<Ros2IronPage> createState() => _Ros2IronPageState();
}

class _Ros2IronPageState extends State<Ros2IronPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
            "Iron Irwini (codename ‘iron’; May, 2023)",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Wrap(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                color: Colors.black,
                child: Center(
                  child: Text(
                    "?",
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
              Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Irwin%27s_turtle_%282261030419%29.jpg/1280px-Irwin%27s_turtle_%282261030419%29.jpg",
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
