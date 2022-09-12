import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/provider/theme_provider.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_3_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/screen/kaigi_main_screen.dart';
import 'src/screen/theme/theme_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void main() async {
  usePathUrlStrategy();
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(ProviderScope(child: FlutterDroidKaigi2022App()));
  } else {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(ProviderScope(child: FlutterDroidKaigi2022App()));
    }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
  }
}

class FlutterDroidKaigi2022App extends StatelessWidget {
  FlutterDroidKaigi2022App({super.key});

  final GoRouter _router = GoRouter(
    observers: [
      FirebaseAnalyticsObserver(analytics: analytics),
    ],
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const KaigiMainScreen();
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeData = ref.watch(themeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Droidkaigi2022',
          theme: themeData,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          routerDelegate: _router.routerDelegate,
        );
      },
    );
  }
}

class KaigiMainScreen extends StatefulWidget {
  const KaigiMainScreen({Key? key}) : super(key: key);

  @override
  State<KaigiMainScreen> createState() => _KaigiMainScreenState();
}

class _KaigiMainScreenState extends State<KaigiMainScreen> {
  int _pageIndex = 0;
  bool _railExtended = true;

  Widget buildIndexStack() {
    return IndexedStack(
      index: _pageIndex,
      children: [
        KaigiHomeScreen(),
        Flutter3Screen(),
        const ThemeScreen(),
        Container(),
        Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              centerTitle: true,
              backgroundColor: Colors.black,
              title: SvgPicture.asset(
                "assets/2022Logo.svg",
                width: 200,
              ),
            ),
            body: buildIndexStack(),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _pageIndex,
              onDestinationSelected: (idx) {
                setState(() {
                  _pageIndex = idx;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Icons.flutter_dash),
                  label: "Flutter3",
                ),
                NavigationDestination(
                  icon: Icon(Icons.palette_outlined),
                  label: "Theme",
                ),
                NavigationDestination(
                  icon: Icon(Icons.smart_toy_outlined),
                  label: "ROS2",
                ),
                NavigationDestination(
                  icon: Icon(Icons.view_in_ar_outlined),
                  label: "Monitor",
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: SvgPicture.asset(
              "assets/2022Logo.svg",
              width: 200,
            ),
          ),
          body: Row(
            children: [
              NavigationRail(
                onDestinationSelected: (idx) {
                  setState(() {
                    _pageIndex = idx;
                  });
                },
                extended: _railExtended,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.flutter_dash),
                    label: Text("Flutter3"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.palette_outlined),
                    label: Text("Design & Theme"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.smart_toy_outlined),
                    label: Text("ROS2"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.view_in_ar_outlined),
                    label: Text("Monitor"),
                  ),
                ],
                elevation: 4,
                selectedIndex: _pageIndex,
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _railExtended = !_railExtended;
                          });
                        },
                        child: _railExtended
                            ? const Icon(
                                Icons.arrow_back_outlined,
                              )
                            : const Icon(
                                Icons.arrow_forward,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: buildIndexStack(),
              ),
            ],
          ),
        );
      },
    );
  }
}
