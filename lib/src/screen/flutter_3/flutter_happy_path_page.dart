import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterHappyPathPage extends StatefulWidget {
  const FlutterHappyPathPage({Key? key}) : super(key: key);

  @override
  State<FlutterHappyPathPage> createState() => _FlutterHappyPathPageState();
}

class _FlutterHappyPathPageState extends State<FlutterHappyPathPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              "https://docs.flutter.dev/assets/images/docs/happy-paths/HappyPaths_HeaderImage_003.png",
              height: 200,
            ),
            ListTile(
              title: const Text("Happy paths project"),
              subtitle: const Text("Happy paths recommendations"),
              onTap: () {
                launchUrl(Uri.parse("https://docs.flutter.dev/development/packages-and-plugins/happy-paths"));
              },
              leading: const Icon(Icons.newspaper),
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Ads"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("google_mobile_ads"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/google_mobile_ads/install"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Background processing"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("workmanager"),
                  subtitle: const Text("fluttercommunity.dev"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/workmanager"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Geolocation"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("geolocator - Flutter Favorite"),
                  subtitle: const Text("baseflow.com"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/geolocator"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Immutable data"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("freezed - Flutter Favorite"),
                  subtitle: const Text("dash-overflow.net"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/freezed#how-to-use"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
                ListTile(
                  title: const Text("json_serializable  - Flutter Favorite"),
                  subtitle: const Text("google.dev"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/json_serializable"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Structured local storage"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("hive"),
                  subtitle: const Text("hivedb.dev"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/hive"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
                ListTile(
                  title: const Text("drift　(以前moor) - Flutter Favorite"),
                  subtitle: const Text("simonbinder.eu"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/drift"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text("Web sockets"),
              leading: const Icon(Icons.folder),
              children: [
                ListTile(
                  title: const Text("web_socket_channel"),
                  subtitle: const Text("tools.dart.dev"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/web_socket_channel"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
                ListTile(
                  title: const Text("shelf_web_socket"),
                  subtitle: const Text("tools.dart.dev"),
                  onTap: () {
                    launchUrl(Uri.parse("https://pub.dev/packages/shelf_web_socket"));
                  },
                  leading: const Icon(Icons.inventory_2_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
