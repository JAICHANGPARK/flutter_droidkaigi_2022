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
  return ThemeController(themeData, ref);
});

class ThemeController extends StateNotifier<ThemeData> {
  // bool useMaterial3 = true;
  // bool useLightMode = true;
  // int colorSelected = 0;
  Ref ref;


  ThemeController(super.state, this.ref);

  ThemeData updateThemes(int colorIndex, bool useMaterial3, bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: colorOptions[colorIndex],
        useMaterial3: useMaterial3,
        brightness: useLightMode ? Brightness.light : Brightness.dark,

    );
  }

  void handleBrightnessChange() {
    int oldColorSelected = ref.read(colorSelected);
    bool oldUseMaterial3 = ref.read(useMaterial3);
    bool oldUseLightMode = ref.read(useLightMode);
    oldUseLightMode = !oldUseLightMode;
    ref.read(useLightMode.notifier).state = oldUseLightMode;
    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }

  void handleMaterialVersionChange() {
    int oldColorSelected = ref.read(colorSelected);
    bool oldUseMaterial3 = ref.read(useMaterial3);
    bool oldUseLightMode = ref.read(useLightMode);

    oldUseMaterial3 = !oldUseMaterial3;
    ref.read(useMaterial3.notifier).state = oldUseMaterial3;
    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }

  void handleColorSelect(int value) {
    int oldColorSelected = ref.read(colorSelected);
    bool oldUseMaterial3 = ref.read(useMaterial3);
    bool oldUseLightMode = ref.read(useLightMode);

    oldColorSelected = value;
    ref.read(colorSelected.notifier).state = oldColorSelected;

    state = updateThemes(oldColorSelected, oldUseMaterial3, oldUseLightMode);
  }
}
