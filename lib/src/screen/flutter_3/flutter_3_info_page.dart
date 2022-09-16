import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Flutter3InfoPage extends StatefulWidget {
  const Flutter3InfoPage({Key? key}) : super(key: key);

  @override
  State<Flutter3InfoPage> createState() => _Flutter3InfoPageState();
}

class _Flutter3InfoPageState extends State<Flutter3InfoPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "May 11, 2022, Google I/O Edition: Flutter 3 release",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: const Text("Introducing Flutter 3"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://medium.com/flutter/introducing-flutter-3-5eb69151622f"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: const Text("What’s new in Flutter 3"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://medium.com/flutter/whats-new-in-flutter-3-8c74a5bc32d0"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: const Text("Dart 2.17: Productivity and integration"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://medium.com/dartlang/dart-2-17-b216bfc80c5d"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Flutter Casual Game Kit",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 16),
                                  height: 2,
                                  width: 64,
                                  color: Colors.grey,
                                ),
                                Text(
                                    """🕹👾 Announcing the Flutter Casual Games Toolkit! Let Flutter help you get your game from idea to launch. Get started now → https://goo.gle/39bA01N """),
                                Image.network("https://pbs.twimg.com/media/FSgl1OfUcAEsiQV?format=jpg&name=small"),
                                Text('@FlutterDev'),
                              ],
                            ),
                          );
                        });
                  },
                  child: Image.network(
                    "https://storage.googleapis.com/cms-storage-bucket/675a58f90edf458780d5.png",
                    height: 400,
                  ),
                ),
                Text("source: https://flutter.dev/games"),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://pinball.flutter.dev/"));
              },
              child: Image.network("https://raw.githubusercontent.com/flutter/pinball/main/art/readme_header.png"),
            ),
            ListTile(
              title: const Text("Google I/O Pinball"),
              subtitle: Text("押すとゲームが実行されます。"),
              leading: const Icon(Icons.sports_esports_outlined),
              onTap: () {
                launchUrl(Uri.parse("https://pinball.flutter.dev/"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: const Text("Casual Games Toolkit"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://docs.flutter.dev/resources/games-toolkit"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(),
            Text(
              "Aug 31, 2022, Flutter Vikings Edition: 3.3 release",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: const Text("Announcing Flutter 3.3 at Flutter Vikings"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(
                    Uri.parse("https://medium.com/flutter/announcing-flutter-3-3-at-flutter-vikings-6f213e068793"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: const Text("What’s new in Flutter 3.3"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://medium.com/flutter/whats-new-in-flutter-3-3-893c7b9af1ff"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              title: const Text("Dart 2.18: Objective-C & Swift interop"),
              leading: const Icon(Icons.newspaper),
              onTap: () {
                launchUrl(Uri.parse("https://medium.com/dartlang/dart-2-18-f4b3101f146c"));
              },
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Divider(),
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
            Text("アップルペンシルでお試しください"),
            SizedBox(
              height: 320,
              child: Column(
                children: [
                  Expanded(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
