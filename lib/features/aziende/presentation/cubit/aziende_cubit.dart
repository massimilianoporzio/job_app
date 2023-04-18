import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/core/domain/entities/annuncio.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/log/bloc_logger.dart';
import '../../domain/usecases/fetch_all_annunci.dart';

part 'aziende_state.dart';

class AziendeCubit extends Cubit<AziendeState> with BlocLoggy {
  final FetchAnnunciAzienda fectAnnunciUsecase;
  AziendeCubit({required this.fectAnnunciUsecase})
      : super(const AziendeStateInitial());

  void fetchAllAnnunci() async {
    final response = await fectAnnunciUsecase(const AnnunciAzParams());
    response.fold(
      (l) => emit(const AziendeStateError(message: "ERRORE")),
      (r) {
        loggy.debug("AL CUBIT è arrivato:");
        loggy.debug(r as List<Annuncio>);
        return emit(AziendeStateLoaded(listaAnnunci: r));
      },
    );
  }
}
