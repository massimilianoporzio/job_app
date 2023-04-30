import 'package:dartz/dartz.dart';

import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:job_app/core/domain/enums/tipologia_annunci.dart';
import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/features/preferiti/domain/entities/preferito.dart';

abstract class PreferitiRepository {
  //recupera info aggiornate da notion
  Future<Either<Failure, Preferito>> fetchPreferito({
    required String annuncioId,
    required TipoAnnuncio tipoAnnuncio,
  });

  Future<Either<Failure, ListaPreferiti>> fetchListaPreferiti();
  Future<Either<Failure, Unit>> aggiungiPreferito(Preferito preferito);
  Future<Either<Failure, Unit>> aggiornaPreferito(Preferito preferito);
  Future<Either<Failure, Unit>> rimuoviPreferito(String annuncioId);
}
