import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/aziende_cubit.dart';

class AnnunciRecenti extends StatelessWidget {
  const AnnunciRecenti({
    super.key,
    required this.mWidth,
    required this.orientation,
  });

  final double mWidth;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: orientation == Orientation.portrait ? 10 : 0),
      width: orientation == Orientation.portrait ? 0.9 * mWidth : 0.1 * mWidth,
      child: Card(
        color:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.75),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<AziendeCubit, AziendeState>(
                builder: (context, state) {
                  String num = "0";
                  if (state is AziendeStateLoaded) {
                    num = state.numeroAnnunciRecenti;
                  }
                  return Text(num,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ));
                },
              ),
              Text(
                "annunci\nrecenti",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: orientation == Orientation.portrait ? 12 : 9,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
