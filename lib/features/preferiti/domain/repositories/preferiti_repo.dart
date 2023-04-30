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
}
