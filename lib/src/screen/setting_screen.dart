import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                "Droidkaigi2022のために作られたアプリケーションです。",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Divider(),
              ListTile(
                title: const Text("オープンソースライセンス"),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  showLicensePage(context: context);
                },
              ),
              ListTile(
                title: const Text("レポジトリ"),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  launchUrl(
                    Uri.parse("https://github.com/JAICHANGPARK/flutter_droidkaigi_2022"),
                  );
                },
              ),
              const Divider(),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String appName = snapshot.data?.appName ?? "";
                    String packageName = snapshot.data?.packageName ?? "";
                    String version = snapshot.data?.version ?? "";
                    String buildNumber = snapshot.data?.buildNumber ?? "";
                    return Column(
                      children: [
                        ListTile(
                          title: const Text("App Name"),
                          trailing: Text("$appName"),
                        ),
                        ListTile(
                          title: const Text("packageName"),
                          trailing: Text("$packageName"),
                        ),
                        ListTile(
                          title: const Text("version (buildNumber)"),
                          trailing: Text("$version ($buildNumber)"),
                        )
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
