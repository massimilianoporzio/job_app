import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/dark_mode_cubit.dart';
import 'package:job_app/app/resources/theme_manager.dart';
import 'package:job_app/app/presentation/pages/splash_screen.dart';

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //dipende dallo stato del cubit DarkModeCubit
        themeMode: context.select((DarkModeCubit themeCubit) {
          return themeCubit.state.mode;
        }),
        theme: ThemeManager.getLightTheme(),
        darkTheme: ThemeManager.getDarkTheme(),
        home: const SplashScreen());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const JobApp();
  }
}
