import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/core/domain/usecases/base_usecase.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';

class FetchAnnunciAzienda extends BaseUseCase {
  AziendeRepository repository;
  FetchAnnunciAzienda({
    required this.repository,
  });
  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.fetchAnnunciAziende(params);
  }
}

class AnnunciAzParams extends Equatable {
  final bool? askFirstPage; //la pagina da richiedere
  final bool? askNextPage; //se richiedo la pagina successiva
  const AnnunciAzParams({
    this.askFirstPage,
    this.askNextPage,
  });

  @override
  List<Object?> get props => [askFirstPage, askNextPage];
}
