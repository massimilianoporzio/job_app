import 'package:dartz/dartz.dart';
import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/errors/failures.dart';
import '../../../../core/domain/usecases/base_usecase.dart';

abstract class AziendeRepository {
  // Future<Either<Failure, AnnuncioAziendaList>> fetchAnnunciAziende(
  //     AnnunciAzParams params);
  Future<Either<Failure, AnnuncioAziendaList>> loadAnnunciAziende(
      AnnunciAzParams params);
  Future<Either<Failure, AnnuncioAziendaList>> refreshAnnunciAziende(
      AnnunciAzParams params);
  Future<Either<Failure, AnnuncioAzienda>> fetchAnnuncio(
      AnnunciAzParams params);
}
