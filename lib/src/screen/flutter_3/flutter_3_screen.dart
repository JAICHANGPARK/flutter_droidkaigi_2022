import 'package:flutter/material.dart';

class Flutter3Screen extends StatefulWidget {
  const Flutter3Screen({Key? key}) : super(key: key);

  @override
  State<Flutter3Screen> createState() => _Flutter3ScreenState();
}

class _Flutter3ScreenState extends State<Flutter3Screen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SelectionArea",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SelectionArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Selection Row 1'),
                    Text('Selection Row 2'),
                    Text('Selection Row 3'),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Scribble",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 320,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          maxLines: 10,
                          scribbleEnabled: true,
                          
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Scribble text",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
