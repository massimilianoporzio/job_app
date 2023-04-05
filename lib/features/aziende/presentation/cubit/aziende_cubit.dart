import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'aziende_state.dart';

class AziendeCubit extends Cubit<AziendeState> {
  AziendeCubit() : super(AziendeInitial());
}
