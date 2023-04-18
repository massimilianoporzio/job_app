import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:job_app/app/resources/color_manager.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:job_app/features/aziende/presentation/pages/dettagli_annuncio_aziende.dart';
import 'package:loggy/loggy.dart';

import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/domain/enums/seniority.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    super.key,
    required this.mHeigth,
    required this.listaAnnunci,
  });

  final double mHeigth;
  final AnnuncioList listaAnnunci;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      key: const PageStorageKey<String>(
          'Aziende'), //mi tiene la posizione in cui ero
      itemCount: listaAnnunci.length,
      itemBuilder: (context, index) => SizedBox(
        height: 0.2 * mHeigth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CardAzienda(
            index: index,
            annuncio: listaAnnunci[index],
          ),
        ),
      ),
    ));
  }
}

class CardAzienda extends StatelessWidget with UiLoggy {
  final int index;
  final Annuncio annuncio;
  const CardAzienda({
    super.key,
    required this.index,
    required this.annuncio,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        loggy.debug('tapped on annuncio: $index');
        Navigator.of(context).pushNamed(DettaglioAnnunciAziende.routeName,
            arguments: AnnuncioAziendeArguments(index.toString()));
      },
      child: Card(
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
                  const Row(
                    children: [],
                  ),
                  Text(annuncio.localita ?? ""),
                  Text(annuncio.retribuzione ?? ""),
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
      ),
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
