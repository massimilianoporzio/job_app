import 'package:flutter/material.dart';

class AnnuncioAziendeArguments {
  final String annuncioId;

  AnnuncioAziendeArguments(this.annuncioId);
}

class DettaglioAnnunciAziende extends StatelessWidget {
  static const String routeName = "dettaglioAnnuncioAnziende";
  const DettaglioAnnunciAziende({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AnnuncioAziendeArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio'),
      ),
      body: Center(
        child: Text("DETTAGLI ANNUNCIO con id: ${args.annuncioId}"),
      ),
    );
  }
}
