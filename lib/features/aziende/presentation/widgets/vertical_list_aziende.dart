import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:job_app/app/resources/color_manager.dart';

import '../../../../app/resources/enums/seniority.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    super.key,
    required this.mHeigth,
  });

  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => SizedBox(
        height: 0.2 * mHeigth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CardAzienda(index: index),
        ),
      ),
    ));
  }
}

class CardAzienda extends StatelessWidget {
  final int index;
  const CardAzienda({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                ColorManager.veryLightRed
                    .harmonizeWith(
                        Theme.of(context).colorScheme.secondaryContainer)
                    .withOpacity(0.2),
                Theme.of(context).colorScheme.secondaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // child: Center(child: Text('$index'))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [],
                ),
                const Text("Milano"),
                const Text("20k-30k a seconda dell'esperienza"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SeniorityChip(
                      seniority: Seniority.junior,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: const AutoSizeText('Full Remote'),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: const AutoSizeText('Full Time'),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class SeniorityChip extends StatelessWidget {
  const SeniorityChip({
    super.key,
    required this.seniority,
  });

  final Seniority seniority;

  @override
  Widget build(BuildContext context) {
    late final Color cardColor;

    switch (seniority) {
      case Seniority.junior:
        cardColor =
            Colors.green.harmonizeWith(Theme.of(context).colorScheme.onPrimary);
        break;
      case Seniority.mid:
        cardColor =
            Colors.amber.harmonizeWith(Theme.of(context).colorScheme.primary);
        break;
      case Seniority.senior:
        cardColor = ColorManager.darkRed
            .harmonizeWith(Theme.of(context).colorScheme.primary);
        break;
      default:
        cardColor = Theme.of(context).colorScheme.primaryContainer;
    }
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: AutoSizeText(
          '$seniority',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
