import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/presentation/cubit/navbar/navigation_cubit.dart';

import '../../../resources/string_constants.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
  });

  Widget build(BuildContext context) {
    int selectedIndex = context.watch<NavigationCubit>().state.selectedIndex;
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        context.read<NavigationCubit>().setPageIndex(index);
      },
      selectedItemColor: Theme.of(context).colorScheme.primary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.corporate_fare),
          label: StringConsts.bottomNavAziende,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: StringConsts.bottomNavBookmarked,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: StringConsts.bottomNavFreelancers,
        ),
      ],
    );
  }
}
