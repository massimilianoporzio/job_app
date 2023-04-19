import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:job_app/core/domain/entities/annuncio.dart';
import 'package:job_app/core/domain/errors/failures.dart';
import 'package:loggy/loggy.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/log/bloc_logger.dart';
import '../../domain/usecases/fetch_all_annunci.dart';

part 'aziende_state.dart';

class AziendeCubit extends Cubit<AziendeState> with BlocLoggy {
  final FetchAnnunciAzienda fectAnnunciUsecase;
  AziendeCubit({required this.fectAnnunciUsecase})
      : super(const AziendeStateInitial());

  void fetchAllAnnunci() async {
    emit(AziendeStateLoading());
    final response = await fectAnnunciUsecase(const AnnunciAzParams());
    response.fold(
      (failure) {
        switch (failure.runtimeType) {
          case NetworkFailure:
            emit(AziendeStateNoConnection());
            break;
          case ServerFailure:
            emit(const AziendeStateError(message: StringConsts.serverError));
            break;
          default:
            emit(const AziendeStateError(message: StringConsts.genericError));
        }
      },
      (r) {
        loggy.debug("AL CUBIT è arrivato:");
        loggy.debug(r as List<Annuncio>);
        return emit(AziendeStateLoaded(listaAnnunci: r));
      },
    );
    // emit(AziendeStateNoConnection());
    // emit(
    //     const AziendeStateError(message: StringConsts.serverError)); //per debug
    emit(const AziendeStateError(
        message: StringConsts.genericError)); //per debug
  }
}
