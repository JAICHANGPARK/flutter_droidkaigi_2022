import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/component/fake_face_widget.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_3_info_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_google_io_22_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_happy_path_page.dart';
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
  final initialContent =
      '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';
  late YoutubePlayerController _controller;
  List<YoutubePlayerController> _controllerItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
      length: 4,
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
                  ),
                  Tab(
                    text: "Happy Path",
                    icon: Icon(Icons.sentiment_satisfied),
                  )
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  const Flutter3InfoPage(),
                  const FlutterGoogleIO22Page(),
                  Column(
                    children: [
                      ListTile(
                        title: const Text("Flutter Vikings - Sept 2022 プレイリスト"),
                        subtitle: const Text("動画が再生できない場合は、プレイリストを確認してください。"),
                        onTap: () {
                          launchUrl(Uri.parse("https://youtube.com/playlist?list=PL4dBIh1xps-EWXK28Qn9kiLK9-eXyqKLX"));
                        },
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      ),
                      Expanded(
                        child: kIsWeb
                            ? VideoListPage(
                                videoListIds: _videoIds,
                              )
                            : (defaultTargetPlatform == TargetPlatform.windows)
                                ? Column(
                                    children: [
                                      const FakeFaceWidget(),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(border: Border.all()),
                                        child: const Text("サポートしていないプラットフォームです。"),
                                      )
                                    ],
                                  )
                                : VideoListPage(
                                    videoListIds: _videoIds,
                                  ),
                      ),
                    ],
                  ),
                  const FlutterHappyPathPage()
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
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
