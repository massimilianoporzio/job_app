import 'package:flutter/material.dart';

import 'annunci_recenti_aziende.dart';
import 'stats_annunci_aziende.dart';
import 'stats_aziende.dart';

class HorizontalStats extends StatelessWidget {
  const HorizontalStats(
      {super.key, required this.mWidth, required this.mHeigth});
  final double mWidth;
  final double mHeigth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          // color: Colors.amber,
          height: 0.4 * mHeigth,
          width: 0.3 * mWidth,
          child: StatAnnunci(
            orientation: Orientation.landscape,
            mWidth: mWidth,
          ),
        ),
        SizedBox(
          // color: Colors.lime,
          height: 0.4 * mHeigth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: StatAziende(
                  mWidth: mWidth,
                  orientation: Orientation.landscape,
                ),
              ),
              AnnunciRecenti(mWidth: mWidth, orientation: Orientation.landscape)
            ],
          ),
        )
      ],
    );
  }
}
