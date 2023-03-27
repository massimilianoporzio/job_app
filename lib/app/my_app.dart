import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:job_app/app/resources/theme_manager.dart';
import 'package:job_app/app/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeManager.getLightTheme(lightDynamic),
        darkTheme: ThemeManager.getDarkTheme(darkDynamic),
        home: const SplashScreen(),
      ),
    );
  }
}
