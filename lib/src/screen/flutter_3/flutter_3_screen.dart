import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayItem {
  String? title;
  String? link;

  VideoPlayItem(this.title, this.link);
}

const List<String> _videoIds = [
  'gn1F7GClECY',
  'C2Zp731g8Es',
  '-BcQAWdtq5E',
  'qAvxnTQQV1M',
  'txyLkDbZoiQ',
  'ffJLpGjLkn8',
];

List<VideoPlayItem> googleIOItems = [
  VideoPlayItem("Flutter at Google I/O 2022 in 5 minutes!", "OOHr8cn2Z0g"),
  VideoPlayItem("What's new in Flutter", "w_ezWG1yKQQ"),
  VideoPlayItem("How to write a Flutter desktop application", "3HREQwLmy88"),
  VideoPlayItem("Create simple, beautiful UI with Flutter", "eBVMfS7MayI"),
  VideoPlayItem("Adding WebView to your Flutter app", "FrqGGw9DYfs"),
  VideoPlayItem("When, why, and how to multithread in Flutter", "yUMjt0AxVHU"),
  VideoPlayItem("Monitoring your Flutter app's stability with Firebase Crashlytics", "cIFLFpKTy7c"),
];

class Flutter3Screen extends StatefulWidget {
  const Flutter3Screen({Key? key}) : super(key: key);

  @override
  State<Flutter3Screen> createState() => _Flutter3ScreenState();
}

class _Flutter3ScreenState extends State<Flutter3Screen> {
  TextEditingController textEditingController = TextEditingController();

  final initialContent =
      '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';
  late YoutubePlayerController _controller;
  List<YoutubePlayerController> _controllerItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // for (var element in googleIOItems) {
    //   _controllerItems.add(YoutubePlayerController(
    //     params: const YoutubePlayerParams(
    //       showControls: true,
    //       mute: false,
    //       showFullscreenButton: true,
    //       loop: false,
    //     ),
    //   )
    //     ..onInit = () {
    //       _controller.loadPlaylist(
    //         list: [element.link ?? ""],
    //         listType: ListType.userUploads,
    //         startSeconds: 0,
    //       );
    //     }
    //     ..onFullscreenChange = (isFullScreen) {
    //       // log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
    //     });
    // }

    // _controller = YoutubePlayerController(
    //   params: const YoutubePlayerParams(
    //     showControls: true,
    //     mute: false,
    //     showFullscreenButton: true,
    //     loop: false,
    //     autoPlay: false,
    //   ),
    // )
    //   ..onInit = () {
    //     _controller.cuePlaylist(
    //       list: googleIOItems.map((e) => e.link ?? "").toList(),
    //       listType: ListType.userUploads,
    //       startSeconds: 0,
    //     );
    //   }
    //   ..onFullscreenChange = (isFullScreen) {
    //     // log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
    //   };
    _controllerItems = List.generate(
      googleIOItems.length,
      (index) => YoutubePlayerController.fromVideoId(
        videoId: googleIOItems[index].link ?? "",
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    for (var element in _controllerItems) {
      element.close();
    }
    super.dispose();
  }

  Size get screenSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
                isScrollable: true,
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: const [
                  Tab(
                    text: "Flutter 3",
                    icon: Icon(Icons.flutter_dash),
                  ),
                  Tab(
                    text: "IO22",
                    icon: Icon(Icons.stadium),
                  ),
                  Tab(
                    text: "Flutter Viking 22",
                    icon: Icon(Icons.sailing),
                  )
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
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
                            onTap: () {
                              launchUrl(Uri.parse("https://medium.com/flutter/introducing-flutter-3-5eb69151622f"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          ListTile(
                            title: const Text("What’s new in Flutter 3"),
                            onTap: () {
                              launchUrl(Uri.parse("https://medium.com/flutter/whats-new-in-flutter-3-8c74a5bc32d0"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          ListTile(
                            title: const Text("Dart 2.17: Productivity and integration"),
                            onTap: () {
                              launchUrl(Uri.parse("https://medium.com/dartlang/dart-2-17-b216bfc80c5d"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          const Divider(),
                          Text(
                            "Aug 31, 2022, Flutter Vikings Edition: 3.3 release",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ListTile(
                            title: const Text("Announcing Flutter 3.3 at Flutter Vikings"),
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "https://medium.com/flutter/announcing-flutter-3-3-at-flutter-vikings-6f213e068793"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          ListTile(
                            title: const Text("What’s new in Flutter 3.3"),
                            onTap: () {
                              launchUrl(Uri.parse("https://medium.com/flutter/whats-new-in-flutter-3-3-893c7b9af1ff"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          ListTile(
                            title: const Text("Dart 2.18: Objective-C & Swift interop"),
                            onTap: () {
                              launchUrl(Uri.parse("https://medium.com/dartlang/dart-2-18-f4b3101f146c"));
                            },
                            trailing: Icon(Icons.keyboard_arrow_right),
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
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: Text("Flutter at I/O 2022 プレイリスト"),
                        subtitle: Text("動画が再生できない場合は、プレイリストを確認してください。"),
                        onTap: () {
                          launchUrl(Uri.parse("https://youtube.com/playlist?list=PLjxrf2q8roU1kHjuHoFGBLCxjy4h2WOcP"));
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Expanded(
                        child: VideoListPage(
                          videoListIds: googleIOItems.map((e) => e.link ?? "").toList(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: Text("Flutter Vikings - Sept 2022 プレイリスト"),
                        subtitle: Text("動画が再生できない場合は、プレイリストを確認してください。"),
                        onTap: () {
                          launchUrl(Uri.parse("https://youtube.com/playlist?list=PL4dBIh1xps-EWXK28Qn9kiLK9-eXyqKLX"));
                        },
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Expanded(
                        child: VideoListPage(
                          videoListIds: _videoIds,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlaylistIconButton extends StatelessWidget {
  ///
  const VideoPlaylistIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.ytController;

    return IconButton(
      onPressed: () async {
        controller.pauseVideo();
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const VideoListPage(),
        //   ),
        // );
        controller.playVideo();
      },
      icon: const Icon(Icons.playlist_play_sharp),
    );
  }
}

///
class VideoListPage extends StatefulWidget {
  ///
  List<String> videoListIds;

  VideoListPage({super.key, required this.videoListIds});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> with AutomaticKeepAliveClientMixin {
  late final List<YoutubePlayerController> _controllers;

  Future<List<YoutubePlayerController>> setController() async {
    return List.generate(
      widget.videoListIds.length,
      (index) => YoutubePlayerController.fromVideoId(
        videoId: widget.videoListIds[index],
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setController().then((value) {
      print("setController done");
      setState(() {
        _controllers = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<YoutubePlayerController>>(
        future: setController(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data?.length ?? "");
            return ListView.separated(
              controller: ScrollController(),
              padding: const EdgeInsets.all(24),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final controller = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: YoutubePlayer(
                      key: ObjectKey(controller),
                      aspectRatio: 16 / 9,
                      enableFullScreenOnVerticalDrag: false,
                      controller: controller
                        ..onFullscreenChange = (_) async {
                          final videoData = await controller.videoData;
                          final startSeconds = await controller.currentTime;

                          // final currentTime = await Navigator.push<double>(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FullScreenPlayerPage(
                          //       videoId: videoData.videoId,
                          //       startSeconds: startSeconds,
                          //     ),
                          //   ),
                          // );

                          // if (currentTime != null) {
                          //   controller.seekTo(seconds: currentTime);
                          // }
                        },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, _) => const SizedBox(height: 16),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
