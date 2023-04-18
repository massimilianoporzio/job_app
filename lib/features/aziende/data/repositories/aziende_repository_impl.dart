import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/core/domain/errors/exceptions.dart';

import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/core/log/repository_logger.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/domain/repositories/aziende_repository.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_all_annunci.dart';

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
  Future<Either<Failure, List<RichTextTextEntity>>> fetchAnnunciAziende(
      AnnunciAzParams params) async {
    String path = StringConsts.baseUrlAziende;
    loggy.debug("REPO: askingAll");
    try {
      final lista = await remoteDS.fetchAll();

      return const Right(<RichTextTextEntity>[]);
    } catch (e) {
      loggy.error(e.toString());
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchPrimaPaginaAnnunci(
      AnnunciAzParams params) {
    // TODO: implement fetchPrimaPaginaAnnunci
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> fetchProssimaPaginaAnnunci(
      AnnunciAzParams params) {
    // TODO: implement fetchProssimaPaginaAnnunci
    throw UnimplementedError();
  }
}
