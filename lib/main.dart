import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/screen/theme/theme_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(ProviderScope(child: FlutterDroidKaigi2022App()));
}

class FlutterDroidKaigi2022App extends StatelessWidget {
  FlutterDroidKaigi2022App({super.key});

  final GoRouter _router = GoRouter(
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
            body: IndexedStack(
              index: _pageIndex,
              children: [
                Container(),
                const ThemeScreen(),
              ],
            ),
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
                  icon: Icon(Icons.palette_outlined),
                  label: "Theme",
                )
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
                    icon: Icon(Icons.palette_outlined),
                    label: Text("Design & Theme"),
                  )
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
                          child:
                              _railExtended ? const Icon(Icons.arrow_back_outlined) : const Icon(Icons.arrow_forward),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: _pageIndex,
                  children: [
                    Container(),
                    const ThemeScreen(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
