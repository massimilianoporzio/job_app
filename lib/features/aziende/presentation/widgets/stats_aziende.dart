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
      width: orientation == Orientation.portrait ? 0.9 * mWidth : 70,
      child: SizedBox(
        height: 60,
        child: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("9",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        )),
                Text(
                  "aziende",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: orientation == Orientation.portrait ? 14 : 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
    );
  }
}
