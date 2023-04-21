import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:loggy/loggy.dart';

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
      body: Center(
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
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(flex: 2, child: Text('Nome azienda')),
                      Expanded(flex: 5, child: Text(annuncio.nomeAzienda))
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
