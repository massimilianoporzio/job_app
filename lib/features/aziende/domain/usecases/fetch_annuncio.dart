import 'package:job_app/core/domain/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/usecases/base_usecase.dart';

class FetchAnnuncio extends BaseUseCase {
  @override
  Future<Either<Failure, dynamic>> call(params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
