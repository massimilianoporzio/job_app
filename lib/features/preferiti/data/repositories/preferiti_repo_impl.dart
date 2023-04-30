import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';

import 'package:job_app/core/domain/enums/tipologia_annunci.dart';
import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/core/log/repository_logger.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/data/mappers/annuncio_azienda_mapper.dart';
import 'package:job_app/features/aziende/data/models/notion_response_azienda.dart';
import 'package:job_app/features/freelancers/data/datasources/freelancers_datasource.dart';
import 'package:job_app/features/freelancers/data/models/notion_response_dto_freelancers.dart';
import 'package:job_app/features/preferiti/domain/entities/preferito.dart';
import 'package:job_app/features/preferiti/domain/repositories/preferiti_repo.dart';

import '../../../../core/domain/errors/exceptions.dart';
import '../../../../core/services/service_locator.dart';
import '../../../freelancers/data/mappers/annuncio_freelancers_mapper.dart';

class PreferitiRepositoryImpl
    with RepositoryLoggy
    implements PreferitiRepository {
  final AziendeDatasource datasourceAziende;
  final FreelancersDatasource datasourceFreelancers;

  PreferitiRepositoryImpl({
    required this.datasourceAziende,
    required this.datasourceFreelancers,
  });
  @override
  Future<Either<Failure, Preferito>> fetchPreferito(
      {required String annuncioId, required TipoAnnuncio tipoAnnuncio}) async {
    loggy.debug("REPO: recupero il preferito con id: $annuncioId");
    NotionResponseAziendaDTO notionResponseAziendaDTO =
        NotionResponseAziendaDTO.empty();
    NotionResponseFreelancersDTO notionResponseFreelancersDTO =
        NotionResponseFreelancersDTO.empty();
    try {
      if (tipoAnnuncio == TipoAnnuncio.aziende) {
        notionResponseAziendaDTO =
            await datasourceAziende.fetchAnnuncio(annuncioId);
        var annuncioModel = notionResponseAziendaDTO.listaAnnunci.first;
        var annuncio = sl<AnnuncioAziendaMapper>().toEntity(annuncioModel);
        final Preferito preferito = Preferito(annuncioAzienda: annuncio);
        return Right(preferito);
      } else {
        notionResponseFreelancersDTO =
            await datasourceFreelancers.fetchAnnuncioFreelancers(annuncioId);
        var annuncioModel = notionResponseFreelancersDTO.listaAnnunci.first;
        var annuncio = sl<AnnuncioFreelancersMapper>().toEntity(annuncioModel);
        final Preferito preferito = Preferito(annuncioFreelancers: annuncio);
        return Right(preferito);
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
  Future<Either<Failure, Unit>> aggiornaPreferito(Preferito preferito) {
    // TODO: implement aggiornaPreferito
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> aggiungiPreferito(Preferito preferito) {
    // TODO: implement aggiungiPreferito
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ListaPreferiti>> fetchListaPreferiti() {
    // TODO: implement fetchListaPreferiti
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> rimuoviPreferito(String annuncioId) {
    // TODO: implement rimuoviPreferito
    throw UnimplementedError();
  }
}
