import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/src/screen/flutter_3/flutter_3_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/kaigi_main_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/ros2/ros2_home_page.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/theme_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
        const KaigiHomeScreen(),
        const Flutter3Screen(),
        const ThemeScreen(),
        const Ros2HomePage(),
        Container(),
      ],
    );
  }

  PreferredSizeWidget buildAppbar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push("/settings");
          },
          icon: const Icon(
            Icons.settings,
          ),
        ),
      ],
      foregroundColor: Colors.white,
      centerTitle: true,
      backgroundColor: Colors.black,
      title: SvgPicture.asset(
        "assets/2022Logo.svg",
        width: 200,
      ),
    );
  }

  Widget buildFab(String heroTag) {
    return FloatingActionButton.extended(
      heroTag: heroTag,
      //"実験室",
      tooltip: "実験室",
      onPressed: () {
        GoRouter.of(context).push("/lab");
      },
      label: const Text("実験室"),
      icon: const Icon(Icons.science),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            appBar: buildAppbar(),
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
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
            floatingActionButton: buildFab("1"),
          );
        }
        return Scaffold(
          appBar: buildAppbar(),
          body: Row(
            children: [
              NavigationRail(
                onDestinationSelected: (idx) {
                  setState(() {
                    _pageIndex = idx;
                  });
                },
                extended: _railExtended,
                labelType: _railExtended ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
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
                        heroTag: "3",
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
          floatingActionButton: buildFab("2"),
        );
      },
    );
  }
}
