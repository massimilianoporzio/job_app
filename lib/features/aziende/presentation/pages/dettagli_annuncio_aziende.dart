import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/services/service_locator.dart';

class AnnuncioAziendeArguments {
  final Annuncio annuncio;

  AnnuncioAziendeArguments(this.annuncio);
}

class DettaglioAnnunciAziende extends StatelessWidget with UiLoggy {
  static const String routeName = "dettaglioAnnuncioAnziende";
  const DettaglioAnnunciAziende({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Column(
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
                      )
                    ],
                  ),
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
    return TextButton(
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () async {
        String scheme = url.startsWith('https') ? 'https' : 'http';
        Uri webUri = Uri(
          scheme: scheme,
          path: url,
        );

        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri);
        } else {
          throw "Errore nell'apertura"; //TODO: gestire con messaggio UI
        }
      },
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 3,
            child: Row(
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
        Expanded(flex: 5, child: valore)
      ],
    );
  }
}
