import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = Colors.blueGrey;
  static final defaultLightColorScheme =
      ColorScheme.fromSeed(seedColor: Color(0xFF027DFD));

  static final defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Color(0xFF061D5C), brightness: Brightness.dark);
}
