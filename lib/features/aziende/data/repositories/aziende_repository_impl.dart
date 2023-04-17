import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';

import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_annunci_azienda.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/resources/string_constants.dart';

class AziendeRepositoryImpl implements AziendeRepository {
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
        logDebug("REPO: askingAll");
        remoteDS.fetchAll();
        return const Right(<RichTextTextEntity>[]);
      } else {
        return const Right(<RichTextTextEntity>[]);
      }
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
