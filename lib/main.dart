import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/game/manager/game_manager.dart';
import 'package:flutter_droidkaigi_2022/src/kaigi_main_screen.dart';
import 'package:flutter_droidkaigi_2022/src/provider/theme_provider.dart';
import 'package:flutter_droidkaigi_2022/src/screen/enter_vertical_text.dart';
import 'package:flutter_droidkaigi_2022/src/screen/lab/lab_home_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/setting_screen.dart';
import 'package:flutter_droidkaigi_2022/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

FirebaseAnalytics? analytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<GameManager>(GameManager());
  usePathUrlStrategy();

  if (kIsWeb) {
    print("This is Web");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    analytics = FirebaseAnalytics.instance;

    return runApp(
      ProviderScope(
        child: FlutterDroidKaigi2022App(),
      ),
    );
  } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
    return runApp(
      ProviderScope(
        child: FlutterDroidKaigi2022App(),
      ),
    );
  } else {
    runZonedGuarded<Future<void>>(
      () async {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        analytics = FirebaseAnalytics.instance;
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

        return runApp(ProviderScope(child: FlutterDroidKaigi2022App()));
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      ),
    );
  }
}

class FlutterDroidKaigi2022App extends StatelessWidget {
  FlutterDroidKaigi2022App({super.key});

  final GoRouter _router = GoRouter(
    observers: kIsWeb
        ? [
            FirebaseAnalyticsObserver(
              analytics: analytics ?? FirebaseAnalytics.instance,
            ),
          ]
        : (defaultTargetPlatform == TargetPlatform.windows ||
                defaultTargetPlatform == TargetPlatform.linux ||
                defaultTargetPlatform == TargetPlatform.fuchsia)
            ? []
            : [
                FirebaseAnalyticsObserver(
                  analytics: analytics ?? FirebaseAnalytics.instance,
                ),
              ],
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // return const EnterScreen();
          return EnterVerticalTextPage();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const KaigiMainScreen();
        },
      ),
      GoRoute(
        path: '/lab',
        builder: (BuildContext context, GoRouterState state) {
          return const LabHomeScreen();
        },
      ),
      GoRoute(
        path: "/settings",
        builder: (context, state) => const SettingScreen(),
      )
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
