import 'package:flutter/material.dart';
import 'package:job_app/features/aziende/presentation/pages/dettagli_annuncio_aziende.dart';
import 'package:job_app/features/freelancers/presentation/pages/dettagli_annuncio_freelancers.dart';

import 'package:loggy/loggy.dart';

import '../../../../core/domain/entities/annuncio_args.dart';
import '../../domain/entities/preferito.dart';

class AnnuncioActionsPreferiti extends StatefulWidget {
  const AnnuncioActionsPreferiti({
    super.key,
    required this.loggy,
    required this.annuncio,
  });

  final Loggy<UiLoggy> loggy;
  final Preferito annuncio;

  @override
  State<AnnuncioActionsPreferiti> createState() =>
      _AnnuncioActionsPreferitiState();
}

class _AnnuncioActionsPreferitiState extends State<AnnuncioActionsPreferiti>
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
            //per ora non lo uso
            widget.loggy.debug("${widget.annuncio.annuncioId} FAVORITO?");
          },
          icon: Icon(widget.annuncio.preferito
              ? Icons.bookmark
              : Icons.bookmark_outline),
        ),
        IconButton(
            onPressed: () {
              widget.loggy.debug("VAI AL DETTAGLIO");
              Navigator.of(context).pushNamed(
                  widget.annuncio.isAzienda
                      ? DettaglioAnnunciAziende.routeName
                      : DettaglioAnnunciFreelancers.routeName,
                  arguments: AnnuncioArguments(
                    annuncioId: widget.annuncio.annuncioId,
                    tipoAnnuncio: widget.annuncio.tipoAnnuncio,
                  ));
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
