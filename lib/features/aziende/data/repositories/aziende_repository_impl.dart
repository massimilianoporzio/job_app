import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/core/domain/errors/exceptions.dart';

import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/core/log/repository_logger.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_annunci_azienda.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/resources/string_constants.dart';

class AziendeRepositoryImpl with RepositoryLoggy implements AziendeRepository {
  bool hasNext;
  String nextCursor;
  final AziendeDatasource remoteDS;

  AziendeRepositoryImpl({
    this.hasNext = true,
    this.nextCursor = "",
    required this.remoteDS,
  });

  @override
  Future<Either<Failure, dynamic>> fetchAnnunciAziende(
      AnnunciAzParams params) async {
    bool? askingNextPage =
        params.askNextPage; //se c'è chiedo la pagina successiva
    bool? askFirstPage =
        params.askFirstPage; //se c'è chiedo la paginazione altrimenti tutte
    bool askingAll = false;
    if (askingNextPage == null && askFirstPage == null) {
      askingAll =
          true; //se non ho i due bool vuol dire che chiedo tutti gli annunci
    }
    try {
      if (askingAll) {
        String path = StringConsts.baseUrlAziende;
        loggy.debug("REPO: askingAll");

        try {
          remoteDS.fetchAll();
        } on Exception {
          rethrow;
        }

        return const Right(<RichTextTextEntity>[]);
      } else {
        return const Right(<RichTextTextEntity>[]);
      }
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
