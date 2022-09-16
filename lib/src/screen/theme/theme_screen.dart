import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/const.dart';
import 'package:flutter_droidkaigi_2022/src/provider/theme_provider.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/app_bar_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/color_palettes_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/component_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/elevation_screen.dart';
import 'package:flutter_droidkaigi_2022/src/screen/theme/typography_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(builder: (context, ref, _) {
            final state = ref.watch(useLightMode);
            return SwitchListTile(
              title: Row(
                children: [
                  state ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.wb_sunny),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Light Mode"),
                ],
              ),
              value: state,
              onChanged: (b) {
                ref.read(themeProvider.notifier).handleBrightnessChange();
              },
            );
          }),
          Consumer(builder: (context, ref, _) {
            final state = ref.watch(useMaterial3);
            return SwitchListTile(
              title: const Text("Material 3"),
              value: state,
              onChanged: (b) {
                ref.read(themeProvider.notifier).handleMaterialVersionChange();
              },
            );
          }),
          Consumer(builder: (context, ref, _) {
            int state = ref.watch(colorSelected);
            return ListTile(
              title: const Text("Color Scheme"),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                itemBuilder: (context) {
                  return List.generate(colorOptions.length, (index) {
                    return PopupMenuItem(
                      value: index,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              index == state ? Icons.color_lens : Icons.color_lens_outlined,
                              color: colorOptions[index],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              colorText[index],
                            ),
                          )
                        ],
                      ),
                    );
                  });
                },
                onSelected: ref.read(themeProvider.notifier).handleColorSelect,
              ),
            );
          }),
          const Divider(),
          TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              indicatorColor: Theme.of(context).colorScheme.primary,
              isScrollable: true,
              tabs: const [
                Tab(
                  icon: Icon(Icons.widgets_outlined),
                  text: "Components",
                ),
                Tab(
                  icon: Icon(Icons.brightness_auto_rounded),
                  text: "AppBar",
                ),
                Tab(
                  icon: Icon(Icons.format_paint_outlined),
                  text: "Color",
                ),
                Tab(
                  icon: Icon(Icons.text_fields),
                  text: "Typography",
                ),
                Tab(
                  icon: Icon(Icons.invert_colors_on_outlined),
                  text: "Elevation",
                )
              ]),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ComponentScreen(showNavBottomBar: true),
                AppBarScreen(),
                ColorPalettesScreen(),
                TypographyScreen(),
                ElevationScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
