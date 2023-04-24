import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'aziende_filter_state.dart';

class AziendeFilterCubit extends Cubit<AziendeFilterState> {
  AziendeFilterCubit() : super(AziendeFilterState.initial());

  void setJuniorSeniorityFilter(bool selected) {
    emit(state.copyWith(juniorSeniorityFilter: selected));
  }

  void setMidSeniorityFilter(bool selected) {
    emit(state.copyWith(midSeniorityFilter: selected));
  }

  void setSeniorSeniorityFilter(bool selected) {
    emit(state.copyWith(juniorSeniorityFilter: selected));
  }
}
