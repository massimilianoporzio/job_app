import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/domain/entities/typedefs.dart';
import '../pages/dettagli_annuncio_aziende.dart';
import 'chips.dart';

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
        height: 0.275 * mHeigth,
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

    return InkWell(
      onTap: () {
        loggy.debug('tapped on annuncio: $index');
        // Navigator.of(context).pushNamed(DettaglioAnnunciAziende.routeName,
        //     arguments: AnnuncioAziendeArguments(index.toString()));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        child: Container(
            decoration: BoxDecoration(
              // color: ColorManager.notionLightBoxGrey,

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
                          style: const TextStyle(fontSize: 18),
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
                  Text(annuncio.nomeAzienda.content,
                      style: const TextStyle(fontSize: 14)),
                  if (annuncio.retribuzione != null)
                    AutoSizeText(
                      annuncio.retribuzione!,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14),
                    ),
                  AnnuncioActions(loggy: loggy, annuncio: annuncio),

                  BlocBuilder<DarkModeCubit, DarkModeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (annuncio.seniority != null)
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SeniorityChip(
                                seniorityEntity: annuncio.seniority!,
                                mode: state.mode,
                              ),
                            ),
                          ContrattoChip(
                            contrattoEntity: annuncio.contratto!,
                            mode: state.mode,
                          ),
                          TeamChip(
                            teamEntity: annuncio.team!,
                            mode: state.mode,
                          )
                        ],
                      );
                    },
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

class AnnuncioActions extends StatefulWidget {
  const AnnuncioActions({
    super.key,
    required this.loggy,
    required this.annuncio,
  });

  final Loggy<UiLoggy> loggy;
  final Annuncio annuncio;

  @override
  State<AnnuncioActions> createState() => _AnnuncioActionsState();
}

class _AnnuncioActionsState extends State<AnnuncioActions>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )
      ..reverse()
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            widget.loggy.debug("${widget.annuncio.id} FAVORITO?");
          },
          icon: const Icon(Icons.bookmark_outline),
        ),
        IconButton(
            onPressed: () {
              widget.loggy.debug("VAI AL DETTAGLIO");
              Navigator.of(context).pushNamed(DettaglioAnnunciAziende.routeName,
                  arguments: AnnuncioAziendeArguments(widget.annuncio));
            },
            // icon: const Icon(CupertinoIcons.ellipsis),
            icon: AnimatedIcon(
              icon: AnimatedIcons.search_ellipsis,
              progress: _animationController,
            )),
      ],
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
                  style: const TextStyle(fontSize: 12),
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
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
