import 'package:flutter/material.dart';
import 'package:flutter_droidkaigi_2022/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final useMaterial3 = StateProvider<bool>((ref) => true);
final useLightMode = StateProvider<bool>((ref) => true);
final colorSelected = StateProvider<int>((ref) => 0);

final themeProvider = StateNotifierProvider<ThemeController, ThemeData>((ref) {
  final themeData = ThemeData(
    colorSchemeSeed: colorOptions[0],
    useMaterial3: ref.read(useMaterial3),
    brightness: ref.read(useLightMode) ? Brightness.light : Brightness.dark,

  );
  return ThemeController(themeData, ref.read);
});

class ThemeController extends StateNotifier<ThemeData> {
  // bool useMaterial3 = true;
  // bool useLightMode = true;
  // int colorSelected = 0;
  Reader read;

  ThemeController(super.state, this.read);

  ThemeData updateThemes(int colorIndex, bool useMaterial3, bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: colorOptions[colorIndex],
        useMaterial3: useMaterial3,
        brightness: useLightMode ? Brightness.light : Brightness.dark,

    );
  }

  void handleBrightnessChange() {
    int oldColorSelected = read(colorSelected);
    bool oldUseMaterial3 = read(useMaterial3);
    bool oldUseLightMode = read(useLightMode);
    oldUseLightMode = !oldUseLightMode;
    read(useLightMode.notifier).state = oldUseLightMode;
    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }

  void handleMaterialVersionChange() {
    int oldColorSelected = read(colorSelected);
    bool oldUseMaterial3 = read(useMaterial3);
    bool oldUseLightMode = read(useLightMode);

    oldUseMaterial3 = !oldUseMaterial3;
    read(useMaterial3.notifier).state = oldUseMaterial3;
    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }

  void handleColorSelect(int value) {
    int oldColorSelected = read(colorSelected);
    bool oldUseMaterial3 = read(useMaterial3);
    bool oldUseLightMode = read(useLightMode);

    oldColorSelected = value;
    read(colorSelected.notifier).state = oldColorSelected;

    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }
}
