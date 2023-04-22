import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:intl/intl.dart';
import 'package:job_app/features/aziende/presentation/widgets/chips.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/presentation/cubit/dark_mode/dark_mode_cubit.dart';
import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/rich_text_utils.dart';

class AnnuncioAziendeArguments {
  final Annuncio annuncio;

  AnnuncioAziendeArguments(this.annuncio);
}

class DettaglioAnnunciAziende extends StatelessWidget with UiLoggy {
  static const String routeName = "dettaglioAnnuncioAnziende";
  const DettaglioAnnunciAziende({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.read<DarkModeCubit>().state.mode;
    final args =
        ModalRoute.of(context)!.settings.arguments as AnnuncioAziendeArguments;
    final annuncio = args.annuncio;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          annuncio.titolo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height,

            width: MediaQuery.of(context).size.width,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (annuncio.emoji != null)
                      Text(
                        sl<EmojiParser>().get(annuncio.emoji).code,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 28),
                      ),
                    if (annuncio.emoji == null)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    IconButton(
                        iconSize: 28,
                        onPressed: () {
                          loggy.debug(
                              "TOGGLE FAVORITO"); //TODO pensare al bloc FavoriteCubit
                        },
                        icon: const Icon(Icons.bookmark_add_outlined))
                  ],
                ),
                AutoSizeText(
                  annuncio.titolo,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    RigaDettaglio(
                      annuncio: annuncio,
                      descrizione: "Nome azienda",
                      iconData: Icons.subject,
                      valore: Text(
                        annuncio.nomeAzienda.content,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ), //Nome azienda
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: CupertinoIcons.link,
                      descrizione: "URL sito web",
                      valore: LinkText(
                        text: annuncio.nomeAzienda.url ?? "",
                        url: annuncio.nomeAzienda.url ?? "",
                      ),
                    ), // URL sito web
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.subject,
                      descrizione: "Qualifica",
                      valore: Text(
                        annuncio.qualifica ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ), //Qualifica
                    const Divider(),
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.schedule,
                      descrizione: "Job posted",
                      valore: Text(
                        DateFormat('dd/MM/yyyy HH:mm')
                            .format(annuncio.jobPosted),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.subject,
                      descrizione: "Come candidarsi",
                      valore: LinkText(
                        text: annuncio.comeCandidarsi.content,
                        url: annuncio.comeCandidarsi.url ?? "",
                      ),
                    ),
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.pin_drop,
                      descrizione: "Località",
                      valore: AutoSizeText(
                        annuncio.localita ?? "",
                        maxFontSize: 12,
                      ),
                    ),
                    const Divider(),

                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.arrow_drop_down_circle_outlined,
                      descrizione: "Seniority",
                      valore: annuncio.seniority == null
                          ? const Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: SeniorityChip(
                                  seniorityEntity: annuncio.seniority!,
                                  mode: mode),
                            ),
                    ), //seniority
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.arrow_drop_down_circle_outlined,
                      descrizione: "Team",
                      valore: annuncio.team == null
                          ? const Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: TeamChip(
                                teamEntity: annuncio.team!,
                                mode: mode,
                              ),
                            ),
                    ),
                    RigaDettaglio(
                      annuncio: annuncio,
                      iconData: Icons.arrow_drop_down_circle_outlined,
                      descrizione: "Contratto",
                      valore: annuncio.contratto == null
                          ? const Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: ContrattoChip(
                                contrattoEntity: annuncio.contratto!,
                                mode: mode,
                              ),
                            ),
                    ),

                    RigaDettaglio(
                      annuncio: annuncio,
                      descrizione: "Retribuzione",
                      iconData: Icons.subject,
                      valore: Text(
                        annuncio.retribuzione ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const Divider(),
                    RigaDettaglio(
                      annuncio: annuncio,
                      descrizione: "Descrizione offerta",
                      iconData: Icons.subject,
                      valore: const SizedBox.shrink(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      // color: Colors.purple,
                      child: SingleChildScrollView(
                          child: getWidgetFromRichTextEntity(
                              annuncio.descrizioneOfferta)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  final String text;
  final String url;

  const LinkText({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        launchUrl(Uri.parse(url));
      },
      child: AutoSizeText(
        text,
        maxFontSize: 12,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class RigaDettaglio extends StatelessWidget {
  final IconData iconData;
  final String descrizione;
  final Widget valore;

  const RigaDettaglio({
    super.key,
    required this.annuncio,
    required this.iconData,
    required this.descrizione,
    required this.valore,
  });

  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    iconData,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  AutoSizeText(descrizione, maxFontSize: 12, maxLines: 2),
                ],
              )),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.zero,
              child: valore,
            ),
          )
        ],
      ),
    );
  }
}
