import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = Colors.blueGrey;
  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey);

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blueGrey, brightness: Brightness.dark);
}
