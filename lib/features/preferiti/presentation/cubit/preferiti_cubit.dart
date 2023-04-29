import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_app/features/aziende/data/mappers/annuncio_azienda_mapper.dart';

import '../../../../core/domain/entities/typedefs.dart';

part 'preferiti_state.dart';

class PreferitiCubit extends Cubit<PreferitiState> {
  PreferitiCubit() : super(PreferitiState.initial());
}
