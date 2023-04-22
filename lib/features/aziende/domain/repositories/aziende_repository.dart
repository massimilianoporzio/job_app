import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/errors/failures.dart';
import '../../../../core/domain/usecases/base_usecase.dart';

abstract class AziendeRepository {
  Future<Either<Failure, AnnuncioList>> fetchAnnunciAziende(
      AnnunciAzParams params);
}
