import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/domain/entities/typedefs.dart';
import 'annuncio_actions.dart';
import 'chips.dart';
import 'job_posted.dart';
import 'localita.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList(
      {super.key, required this.mHeigth, required this.listaAnnunci});
  final double mHeigth;
  final AnnuncioAziendaList listaAnnunci;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 0.45 * mHeigth,
      // color: Colors.purple,
      child: ListView.separated(
        key: const PageStorageKey<String>("Aziende hor"),
        separatorBuilder: (context, index) => const SizedBox(
          width: 3,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          // height: 140,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: SizedBox(
              width: 350,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: CardAziendaHor(
                  annuncio: listaAnnunci[index],
                ),
              ),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}

class CardAziendaHor extends StatelessWidget with UiLoggy {
  final AnnuncioAzienda annuncio;
  const CardAziendaHor({
    super.key,
    required this.annuncio,
  });

  @override
  Widget build(BuildContext context) {
    var serverParser = EmojiParser(init: true);
    var emoji = serverParser.get(annuncio.emoji);
    return InkWell(
      onTap: () {
        loggy.debug('tapped on annuncio: ${annuncio.id}');
        // Navigator.of(context).pushNamed(DettaglioAnnunciAziende.routeName,
        //     arguments: AnnuncioAziendeArguments(index.toString()));
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
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Text(annuncio.nomeAzienda.content,
                    style: const TextStyle(fontSize: 12)),
                if (annuncio.retribuzione != null)
                  AutoSizeText(
                    annuncio.retribuzione!,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
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
          ),
        ),
      ),
    );
  }
}
