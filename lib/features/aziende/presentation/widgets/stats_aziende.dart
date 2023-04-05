import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class StatAziende extends StatelessWidget {
  const StatAziende({
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
          horizontal: orientation == Orientation.landscape ? 0 : 10,
          vertical: 0),
      width: orientation == Orientation.portrait ? 0.9 * mWidth : 0.1 * mWidth,
      child: SizedBox(
        height: 60,
        child: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText("9",
                    presetFontSizes: const [22],
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                AutoSizeText(
                  "aziende",
                  presetFontSizes: [
                    orientation == Orientation.portrait ? 14 : 10,
                  ],
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
    );
  }
}
