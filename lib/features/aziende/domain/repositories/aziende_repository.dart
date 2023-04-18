import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/errors/failures.dart';
import '../usecases/fetch_all_annunci.dart';

abstract class AziendeRepository {
  Future<Either<Failure, AnnuncioList>> fetchAnnunciAziende(
      AnnunciAzParams params);
  Future<Either<Failure, AnnuncioList>> fetchPrimaPaginaAnnunci(
      AnnunciAzParams params);
  Future<Either<Failure, AnnuncioList>> fetchProssimaPaginaAnnunci(
      AnnunciAzParams params);
}
