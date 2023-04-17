import 'package:dartz/dartz.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_annunci_azienda.dart';

import '../../../../core/domain/errors/failures.dart';

abstract class AziendeRepository {
  Future<Either<Failure, dynamic>> fetchAnnunciAziende(AnnunciAzParams params);
}
