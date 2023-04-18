import 'package:dartz/dartz.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_all_annunci.dart';

import '../../../../core/domain/errors/failures.dart';

abstract class AziendeRepository {
  Future<Either<Failure, dynamic>> fetchAnnunciAziende(AnnunciAzParams params);
  Future<Either<Failure, dynamic>> fetchPrimaPaginaAnnunci(
      AnnunciAzParams params);
  Future<Either<Failure, dynamic>> fetchProssimaPaginaAnnunci(
      AnnunciAzParams params);
}
