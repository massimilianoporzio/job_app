import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/dark_mode_cubit.dart';
import 'package:job_app/app/resources/theme_manager.dart';
import 'package:job_app/app/presentation/pages/splash_screen.dart';

import '../core/services/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Funzione che mi restituisce il blocbuilder a cui passo la mia app
  Widget _themeSelector(
      Widget Function(BuildContext context, ThemeMode mode) builder) {
    return BlocBuilder<DarkModeCubit, bool>(
        builder: (context, darkModeEnabled) => builder(
            context, darkModeEnabled ? ThemeMode.dark : ThemeMode.light));
  }

  // This widget is the root of your application.
  @override
  Widget build(_) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic)
          //circondo l'intera MaterialApp con i providers dei bloc che saranno usati
          =>
          MultiBlocProvider(
        providers: [
          //CUBIT DELLA DARK MODE
          BlocProvider<DarkModeCubit>(
            create: (context) => DarkModeCubit(true),
          )
        ],
        child: _themeSelector(
          (context, mode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            //dipende dallo stato del cubit DarkModeCubit
            themeMode: mode,
            theme: ThemeManager.getLightTheme(lightDynamic),
            darkTheme: ThemeManager.getDarkTheme(darkDynamic),
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
