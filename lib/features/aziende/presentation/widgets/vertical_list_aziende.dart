import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/resources/color_manager.dart';
import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/enums/seniority.dart';
import '../pages/dettagli_annuncio_aziende.dart';

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
        height: 0.3 * mHeigth,
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
    var serverParser = EmojiParser(init: true);
    var emoji = serverParser.get(annuncio.emoji);
    print(emoji.code);
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          emoji.code,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Expanded(
                          child: AutoSizeText(annuncio.titolo,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ),
                  Text(annuncio.nomeAzienda, style: TextStyle(fontSize: 14)),
                  if (annuncio.retribuzione != null)
                    Text(annuncio.retribuzione!),
                  IconButton(
                      onPressed: () {
                        loggy.debug("${annuncio.id} FAVORITO?");
                      },
                      icon: Icon(Icons.bookmark_outline)),

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
                  ), //fine riga dei tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("job posted"), Text(annuncio.localita ?? "...")
                      JobPosted(annuncio: annuncio),
                      // Text("prova")
                      Localita(annuncio: annuncio)
                    ],
                  ), //riga data e località
                ],
              ),
            )),
      ),
    );
  }
}

class Localita extends StatelessWidget {
  const Localita({
    super.key,
    required this.annuncio,
  });

  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    String testoLocalita = "";
    if (annuncio.localita != null) {
      testoLocalita = annuncio.localita!.split("(")[0];

      if (testoLocalita.isEmpty) {
        testoLocalita = annuncio.localita!.split(",")[0];
      }
    }

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (testoLocalita.isNotEmpty)
                  const Icon(
                    Icons.pin_drop,
                    size: 12,
                  ),
                Text(
                  testoLocalita,
                  textAlign: TextAlign.end,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobPosted extends StatelessWidget {
  const JobPosted({
    super.key,
    required this.annuncio,
  });

  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.schedule_sharp,
          size: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          DateFormat('dd/MM/yyyy HH:mm').format(annuncio.jobPosted),
          style: TextStyle(fontSize: 12),
        ),
      ],
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
