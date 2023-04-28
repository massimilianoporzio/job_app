import 'package:dartz/dartz.dart';
import 'package:job_app/features/aziende/domain/entities/annuncio_azienda_mapper.dart';
import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';

import 'package:job_app/core/domain/errors/exceptions.dart';

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
  Future<Either<Failure, AnnuncioAziendaList>> fetchAnnunciAziende(
      AnnunciAzParams params) async {
    loggy.debug("REPO: recupero TUTTI gli annunci");
    //TODO devo usare params!
    try {
      late NotionResponseDTO notionResponse;
      // final NotionResponseDTO notionResponse = await remoteDS.fetchAnnunci();
      if (hasMore) {
        notionResponse = nextCursor.isEmpty
            ? await remoteDS.fetchPrimaPaginaAnnunci(params)
            : await remoteDS.fetchProssimaPaginaAnnunci(
                nextCursor, params); //CON PAGINAZIONE
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

  @override
  Future<Either<Failure, AnnuncioAzienda>> fetchAnnuncio(
      AnnunciAzParams params) async {
    try {
      if (params.annuncioId != null) {
        loggy.debug("REPO: recupero l'annuncio con id: ${params.annuncioId}");
        NotionResponseDTO notionResponse =
            await remoteDS.fetchAnnuncio(params.annuncioId!);

        if (notionResponse.listaAnnunci.isEmpty) {
          throw NoAnnuncioException();
        } else {
          var annuncioModel = notionResponse.listaAnnunci.first;
          return Right(AnnuncioMapper().toEntity(annuncioModel));
        }
      } else {
        throw UnimplementedError();
      }
    } on NoAnnuncioException {
      return Left(NoAnnuncioFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } on RestApiException {
      return Left(ServerFailure());
    } on Exception {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, AnnuncioAziendaList>> loadAnnunciAziende(
      AnnunciAzParams params) async {
    loggy.debug("REPO: recupero LA PRIMA pagina degli annunci");

    try {
      late NotionResponseDTO notionResponse;
      // final NotionResponseDTO notionResponse = await remoteDS.fetchAnnunci();

      notionResponse =
          await remoteDS.fetchPrimaPaginaAnnunci(params); //CON PAGINAZIONE
      //USO LA RISPOSTA PER AGGIORNARE STARTCURSOR e HASNEXT
      loggy.debug("notionResponse is: $notionResponse");
      if (notionResponse.hasMore) {
        nextCursor = notionResponse.nextCursor!;
      } else {
        nextCursor = "";
        hasMore = false;
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

  @override
  Future<Either<Failure, AnnuncioAziendaList>> refreshAnnunciAziende(
      AnnunciAzParams params) async {
    loggy.debug("REPO: recupero LA PRIMA pagina degli annunci");

    try {
      late NotionResponseDTO notionResponse;
      // final NotionResponseDTO notionResponse = await remoteDS.fetchAnnunci();
      if (hasMore) {
        notionResponse = await remoteDS.fetchProssimaPaginaAnnunci(
            nextCursor, params); //CON PAGINAZIONE
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
