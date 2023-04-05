import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preferiti_state.dart';

class PreferitiCubit extends Cubit<PreferitiState> {
  PreferitiCubit() : super(PreferitiInitial());
}
