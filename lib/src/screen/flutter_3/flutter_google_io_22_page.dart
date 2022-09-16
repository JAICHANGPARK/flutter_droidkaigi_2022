import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/component/fake_face_widget.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_3_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterGoogleIO22Page extends StatefulWidget {
  const FlutterGoogleIO22Page({Key? key}) : super(key: key);

  @override
  State<FlutterGoogleIO22Page> createState() => _FlutterGoogleIO22PageState();
}

class _FlutterGoogleIO22PageState extends State<FlutterGoogleIO22Page> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: const Text("Flutter at I/O 2022 プレイリスト"),
            subtitle: const Text("動画が再生できない場合は、プレイリストを確認してください。"),
            onTap: () {
              launchUrl(Uri.parse("https://youtube.com/playlist?list=PLjxrf2q8roU1kHjuHoFGBLCxjy4h2WOcP"));
            },
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: kIsWeb
                ? VideoListPage(
                    videoListIds: googleIOItems.map((e) => e.link ?? "").toList(),
                  )
                : (defaultTargetPlatform == TargetPlatform.windows)
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.height / 2,
                              child: const FakeFaceWidget(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(border: Border.all()),
                              child: const Text("サポートしていないプラットフォームです。"),
                            )
                          ],
                        ),
                      )
                    : VideoListPage(
                        videoListIds: googleIOItems.map((e) => e.link ?? "").toList(),
                      ),
          ),
        ],
      ),
    );
  }
}
