import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_patterns/connection.dart';

import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';
import 'package:job_app/app/resources/theme_manager.dart';
import 'package:job_app/app/presentation/pages/splash_screen.dart';
import 'package:job_app/core/services/service_locator.dart';
import 'package:job_app/features/aziende/presentation/cubit/aziende_cubit.dart';
import 'package:job_app/features/aziende/presentation/pages/dettagli_annuncio_aziende.dart';
import 'package:loggy/loggy.dart';

import 'presentation/cubit/dark_mode/dark_mode_cubit.dart';
import 'resources/color_manager.dart';
import 'resources/font_manager.dart';

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    // precacheImage(
    //     const AssetImage("assets/images/splashBackground.jpg"), context);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //dipende dallo stato del cubit DarkModeCubit
        themeMode: context.watch<DarkModeCubit>().state.mode,
        // theme: ThemeManager.getLightTheme(lightDynamic),
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: FontConstants.fontFamily,
            // appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade200),
            colorScheme: lightDynamic ?? ColorManager.defaultLightColorScheme),
        darkTheme: ThemeManager.getDarkTheme(darkDynamic),
        home: const SplashScreen(),
        routes: {
          DettaglioAnnunciAziende.routeName: (context) =>
              const DettaglioAnnunciAziende()
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DarkModeCubit>(
        create: (context) => sl<DarkModeCubit>(),
      ),
      BlocProvider<NavigationCubit>(
        create: (context) => sl<NavigationCubit>(),
      ),
      BlocProvider(
        create: (_) => ConnectionBloc(
          sl<ConnectionRepository>(),
        ),
      ),
      BlocProvider<AziendeCubit>(
        create: (context) {
          var aziendeCubit = sl<AziendeCubit>();
          //qui so che è initial
          if ((aziendeCubit.state as AziendeStateInitial)
              .listaAnnunci
              .isEmpty) {
            //
            logDebug("...state is empty: fetchAllAnnunci...");
            aziendeCubit.fetchAllAnnunci();
            logDebug("...annunci presi...");
          }
          return aziendeCubit;
        },
      ),
    ], child: const JobApp());
  }
}
