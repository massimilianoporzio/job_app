import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/features/aziende/presentation/cubit/aziende_cubit.dart';

import '../../../resources/app_consts.dart';
import '../../cubit/navbar/navigation_cubit.dart';
import 'reusable_primary_button.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/sfondi/Connection_Lost.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 200,
            left: 30,
            child: Text(
              'No Connection',
              style: kTitleTextStyle,
            ),
          ),
          const Positioned(
            bottom: 150,
            left: 30,
            child: Text(
              'Controlla la tua connessione a Internet\ne riprova.',
              style: kSubtitleTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return ReusablePrimaryButton(
                  childText: 'Riprova',
                  buttonColor: Theme.of(context).colorScheme.error,
                  childTextColor: Theme.of(context).colorScheme.onError,
                  onPressed: () {
                    int pageIndex = state.selectedIndex;
                    switch (pageIndex) {
                      case 0:
                        context.read<AziendeCubit>().fetchAllAnnunci();
                        break;
                      default:
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
