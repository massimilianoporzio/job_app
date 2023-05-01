import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:job_app/features/preferiti/domain/usecases/preferiti_filter_params.dart';

part 'preferiti_filters_state.dart';

class PreferitiFiltersCubit extends Cubit<PreferitiFiltersState> {
  PreferitiFiltersCubit() : super(PreferitiFiltersState.initial());
}
