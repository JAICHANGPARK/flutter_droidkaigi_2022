import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class KaigiHomeScreen extends StatefulWidget {
  const KaigiHomeScreen({Key? key}) : super(key: key);

  @override
  State<KaigiHomeScreen> createState() => _KaigiHomeScreenState();
}

class _KaigiHomeScreenState extends State<KaigiHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(
                text: "紹介",
              ),
              Tab(
                text: "発表者",
              ),
              Tab(
                text: "目次",
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 8,
                    right: 8,
                    bottom: 0,
                    top: 8,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FlutterをROS(ロボティクス)と一緒使ったらマジですごかった話",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Wrap(
                                runSpacing: 8,
                                spacing: 8,
                                children: const [
                                  Chip(
                                    label: Text(
                                      "クロスプラットフォーム",
                                    ),
                                  ),
                                  Chip(
                                    label: Text(
                                      "Dialogs － 2022/10/05 11:15-11:55",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "通常、RoboticsではROSとAndroidまたはQTを組み合わせてユーザーアプリケーションを開発しています。"
                                      "今回Flutter3が発表され、デスクトップ、組み込み領域で使用できるように機能が拡張されました。"
                                      "生産性が高いユーザーアプリケーションを作成するためにロボットにFlutterを適用してみました。",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "\n\nそのためには、ロボットとアプリ間通信するためのプロトコルライブラリの開発が必要です。パッケージ開発方法と物語、そして実務で使用している例示を通じて使用機を紹介したいと思います。",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "関連技術",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      "1. Flutter & Flutter Desktop (Linux)",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "2. ROS2",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "3. Websocket",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      "4. gRPC",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: const NetworkImage(
                          "https://avatars.githubusercontent.com/u/19484515?v=4",
                        ),
                        radius: MediaQuery.of(context).size.width / 4,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Dreamwalker(Jai-Chang. Park)",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Flutter & Android Developer",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Text("現"),
                        title: const Text("Flutter Seoul"),
                        subtitle: const Text("2022.9.18 ~"),
                        trailing: const Text("Organizer(運営)"),
                        onTap: () async {
                          await launchUrl(
                            Uri.parse("https://medium.com/flutter-korea"),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Text("前"),
                        title: const Text("Flutter Korea"),
                        subtitle: const Text("~ 2022.9.18"),
                        trailing: const Text("Organizer(運営)"),
                        onTap: () async {
                          await launchUrl(
                            Uri.parse("https://medium.com/flutter-korea"),
                          );
                        },
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("経歴"),
                          ListTile(
                            leading: const Text("現"),
                            title: const Text("Dreamus Company"),
                            subtitle: const Text("Cloud Engineer"),
                            trailing: const Text("2022.07~"),
                            onTap: () async {
                              await launchUrl(
                                Uri.parse("https://www.dreamuscompany.com/"),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Text("前"),
                            title: const Text("Angel Robotics"),
                            subtitle: const Text("Robotics & Software Enginner"),
                            trailing: const Text("2019.01~2022.07"),
                            onTap: () async {
                              await launchUrl(
                                Uri.parse("https://angel-robotics.com/en/"),
                              );
                            },
                          ),
                          const Divider(),
                          const Text("Contact"),
                          ListTile(
                            title: const Text("Github"),
                            subtitle: const Text('JAICHANGPARK'),
                            onTap: () async {
                              await launchUrl(
                                Uri.parse("https://github.com/JAICHANGPARK"),
                              );
                            },
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text("E-mail"),
                        subtitle: const Text("aristojeff@gmail.com"),
                        onTap: () async {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'aristojeff@gmail.com',
                            // query: encodeQueryParameters(<String, String>{
                            //   'subject': 'Example Subject & Symbols are allowed!',
                            // }),
                          );
                          await launchUrl(emailLaunchUri);
                        },
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("スライド"),
                      onTap: () async {
                        // await launchUrl(
                        //   Uri.parse(
                        //     "https://docs.google.com/presentation/d/1OUuQn4M7GQTokhnO7nhYYx78oaCwZu9h_AkFZkIFGbs/edit?usp=sharing",
                        //   ),
                        // );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("1. 今年のFlutterまとめ"),
                      onTap: () async {},
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("2. ROSについて"),
                      onTap: () async {},
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("3. なぜFlutterだったのか"),
                      onTap: () async {},
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("4. FlutterとROSの間やり取りする(インターフェース)方法"),
                      onTap: () async {},
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("5. Demo 🔥"),
                      onTap: () async {},
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
