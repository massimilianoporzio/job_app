import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/resources/string_constants.dart';

import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:job_app/core/domain/errors/failures.dart';
import 'package:job_app/core/domain/usecases/base_usecase.dart';
import 'package:job_app/core/log/bloc_logger.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_all_annunci.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../data/repositories/aziende_repository_impl.dart';
import '../../../domain/repositories/aziende_repository.dart';

part 'aziende_state.dart';

class AziendeCubit extends Cubit<AziendeState> with BlocLoggy {
  final FetchAnnunciAzienda fetchAnnunciUsecase;

  AziendeCubit({
    required this.fetchAnnunciUsecase,
  }) : super(AziendeState.initial());

  reset() {
    emit(AziendeState.initial());
    (sl<AziendeRepository>() as AziendeRepositoryImpl).hasMore = true;
    (sl<AziendeRepository>() as AziendeRepositoryImpl).nextCursor = "";
    fetchAnnunci();
  }

  fetchAnnunci() async {
    bool hasMore = (sl<AziendeRepository>() as AziendeRepositoryImpl).hasMore;
    if (!hasMore) {
      return;
    } else {
      // emit(state.copyWith(status: AziendeStateStatus.loading));

      final response = await fetchAnnunciUsecase(const AnnunciAzParams());
      response.fold(
        (failure) {
          switch (failure.runtimeType) {
            case NetworkFailure:
              emit(state.copyWith(
                  status: AziendeStateStatus.noConnection,
                  message: StringConsts.connectivtyError));
              break;
            case ServerFailure:
              emit(state.copyWith(
                status: AziendeStateStatus.serverFailure,
                message: StringConsts.serverError,
              ));
              break;
            default:
              emit(state.copyWith(
                  status: AziendeStateStatus.error,
                  message: StringConsts.genericError));
          }
        },
        (r) {
          loggy.debug(
              "hasMore is ${(sl<AziendeRepository>() as AziendeRepositoryImpl).hasMore}");

          // loggy.debug(r as List<Annuncio>);
          //TODO da concatenare solo se non è initial e refresh
          AnnuncioList listaAggiornata = [...state.listaAnnunci, ...r];
          // loggy.debug("lista aggiornata: $listaAggiornata");

          emit(state.copyWith(
            status: AziendeStateStatus.loaded,
            listaAnnunci: listaAggiornata,
          ));
        },
      );
    }

    // emit(state.copyWith(status: AziendeStateStatus.loaded, listaAnnunci: []));
    // emit(AziendeStateNoConnection());
    // emit(
    //     const AziendeStateError(message: StringConsts.serverError)); //per debug
    // emit(const AziendeStateError(
    //     message: StringConsts.genericError)); //per debug
  }
}
