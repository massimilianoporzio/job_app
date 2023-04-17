import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/features/aziende/domain/usecases/fetch_annunci_azienda.dart';
import 'package:loggy/loggy.dart';

part 'aziende_state.dart';

class AziendeCubit extends Cubit<AziendeState> {
  final FetchAnnunciAzienda fectAnnunciUsecase;
  AziendeCubit({required this.fectAnnunciUsecase})
      : super(const AziendeStateInitial());

  void fetchAllAnnunci() async {
    final response = await fectAnnunciUsecase(const AnnunciAzParams());
    response.fold(
      (l) => logError("FAILURE!"),
      (r) =>
          emit(AziendeStateLoaded(listaAnnunci: r as List<RichTextTextEntity>)),
    );
  }
}
