import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = Colors.blueGrey;
  static Color darkRed = const Color.fromARGB(255, 161, 1, 1);
  static Color veryLightRed = const Color.fromARGB(255, 228, 214, 214);

  static final defaultLightColorScheme =
      ColorScheme.fromSeed(seedColor: const Color(0xFF027DFD)).harmonized();

  static final defaultDarkColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF061D5C), brightness: Brightness.dark)
      .harmonized();
}
