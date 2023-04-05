import 'package:flutter/material.dart';

import '../../../../app/resources/styles_manager.dart';
import 'bar_chart.dart';

class StatAnnunci extends StatelessWidget {
  const StatAnnunci({
    super.key,
    required this.orientation,
    required this.mWidth,
  });

  final Orientation orientation;
  final double mWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

      // height: 0.15 * mHeight,
      // color: Colors.pink,
      width:
          orientation == Orientation.landscape ? 0.25 * mWidth : 0.6 * mWidth,

      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // color: Theme.of(context).colorScheme.primary,
        child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 10),
                child: Text(
                  "Stats",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("10",
                      style: StyleManager.getBoldStyle(
                          fontSize: 48,
                          color: Theme.of(context).colorScheme.onPrimary)),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "annunci",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        "di assunzioni",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  // color: Colors.green,
                  height: 40,
                  padding: const EdgeInsets.only(left: 8),
                  child: const StatBarChart())
            ],
          ),
        ),
      ),
    );
  }
}