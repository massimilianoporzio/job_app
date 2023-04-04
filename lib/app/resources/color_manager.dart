import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = Colors.blueGrey;
  static final defaultLightColorScheme =
      ColorScheme.fromSeed(seedColor: Color(0xFF027DFD)).harmonized();

  static final defaultDarkColorScheme = ColorScheme.fromSeed(
          seedColor: Color(0xFF061D5C), brightness: Brightness.dark)
      .harmonized();
}
