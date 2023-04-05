import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';

import '../../../features/aziende/presentation/pages/annunci_aziende.dart';
import '../../resources/string_constants.dart';

import '../cubit/dark_mode/dark_mode_cubit.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.pages});

  //lista delle pagine da mostrare
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    var themeMode = context.watch<DarkModeCubit>().state.mode;
    var selectedIndex = context.watch<NavigationCubit>().state.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConsts.appbarTitle,
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DarkModeCubit>().toggleDarkMode();
              },
              icon: Icon(themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode))
        ],
      ),
      bottomNavigationBar: const MyBottomNavBar(),
      body: pages[selectedIndex],
    );
  }
}
