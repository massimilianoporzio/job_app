import 'package:dartz/dartz.dart';

import 'package:job_app/core/domain/errors/exceptions.dart';

import '../../../../core/data/mappers/annuncio_mapper.dart';
import '../../../../core/data/models/notion_response.dart';
import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/errors/failures.dart';
import '../../../../core/domain/usecases/base_usecase.dart';
import '../../../../core/log/repository_logger.dart';
import '../../domain/repositories/aziende_repository.dart';
import '../datasources/aziende_datasource.dart';

class AziendeRepositoryImpl with RepositoryLoggy implements AziendeRepository {
  final AziendeDatasource remoteDS;
  bool hasMore;
  String nextCursor;

  AziendeRepositoryImpl({
    required this.remoteDS,
    this.hasMore = true,
    this.nextCursor = "",
  });
  //IL REPO passa la domain layer entities...qui entrano in gioco
  //i mapper
  @override
  Future<Either<Failure, AnnuncioList>> fetchAnnunciAziende(
      AnnunciAzParams params) async {
    loggy.debug("REPO: recupero gli annunci");

    try {
      late NotionResponseDTO notionResponse;
      // final NotionResponseDTO notionResponse = await remoteDS.fetchAnnunci();
      if (hasMore) {
        notionResponse = nextCursor.isEmpty
            ? await remoteDS.fetchPrimaPaginaAnnunci()
            : await remoteDS
                .fetchProssimaPaginaAnnunci(nextCursor); //CON PAGINAZIONE
        //USO LA RISPOSTA PER AGGIORNARE STARTCURSOR e HASNEXT
        loggy.debug("notionResponse is: $notionResponse");
        if (notionResponse.hasMore) {
          nextCursor = notionResponse.nextCursor!;
        } else {
          nextCursor = "";
          hasMore = false;
        }
      } else {
        notionResponse = NotionResponseDTO.empty();
      }

      return Right(notionResponse.listaAnnunci.annuncioList);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RestApiException {
      return Left(ServerFailure());
    } on Exception {
      return Left(GenericFailure());
    }
  }
}
