import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/core/log/bloc_logger.dart';

part 'aziende_filter_state.dart';

class AziendeFilterCubit extends Cubit<AziendeFilterState> with BlocLoggy {
  AziendeFilterCubit() : super(AziendeFilterState.initial());

  void reset() {
    emit(AziendeFilterState.initial());
  }

  void setSearchTerm(String? searchTerm) {
    loggy.debug("SETTO IL TERMINE DI RICERCA NEL CUBIT");
    emit(state.copyWith(searchTerm: searchTerm));
  }

  void setJuniorSeniorityFilter(bool selected) {
    emit(state.copyWith(juniorSeniorityFilter: selected));
  }

  void setMidSeniorityFilter(bool selected) {
    emit(state.copyWith(midSeniorityFilter: selected));
  }

  void setSeniorSeniorityFilter(bool selected) {
    emit(state.copyWith(seniorSeniorityFilter: selected));
  }
}
