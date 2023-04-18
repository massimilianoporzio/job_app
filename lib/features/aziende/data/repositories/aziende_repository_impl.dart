import 'package:dartz/dartz.dart';
import 'package:job_app/core/data/mappers/annuncio_mapper.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';

import '../../../../app/resources/string_constants.dart';
import '../../../../core/data/models/notion_response.dart';
import '../../../../core/domain/errors/failures.dart';
import '../../../../core/log/repository_logger.dart';

import '../../domain/repositories/aziende_repository.dart';
import '../../domain/usecases/fetch_all_annunci.dart';
import '../datasources/aziende_datasource.dart';

class AziendeRepositoryImpl with RepositoryLoggy implements AziendeRepository {
  bool hasNext;
  String nextCursor;
  final AziendeDatasource remoteDS;

  AziendeRepositoryImpl({
    this.hasNext = true,
    this.nextCursor = "",
    required this.remoteDS,
  });
  //IL REPO passa la domain layer entities...qui entrano in gioco
  //i mapper
  @override
  Future<Either<Failure, AnnuncioList>> fetchAnnunciAziende(
      AnnunciAzParams params) async {
    String path = StringConsts.baseUrlAziende;
    loggy.debug("REPO: askingAll");
    try {
      final NotionResponseDTO notionResponse = await remoteDS.fetchAll();

      return Right(notionResponse.listaAnnunci.annuncioList);
    } catch (e) {
      loggy.error(e.toString());
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, AnnuncioList>> fetchPrimaPaginaAnnunci(
      AnnunciAzParams params) {
    // TODO: implement fetchPrimaPaginaAnnunci
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AnnuncioList>> fetchProssimaPaginaAnnunci(
      AnnunciAzParams params) {
    // TODO: implement fetchProssimaPaginaAnnunci
    throw UnimplementedError();
  }
}
