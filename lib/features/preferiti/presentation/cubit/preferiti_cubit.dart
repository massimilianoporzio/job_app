import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:job_app/features/preferiti/domain/entities/preferito.dart';

import '../../../../core/domain/entities/typedefs.dart';

part 'preferiti_state.dart';

class PreferitiCubit extends HydratedCubit<PreferitiState> {
  PreferitiCubit() : super(PreferitiState.initial());

  @override
  PreferitiState? fromJson(Map<String, dynamic> json) {
    var listaPreferiti = json['preferiti'];
    var preferiti = List<Preferito>.from(
        listaPreferiti.map((model) => Preferito.fromJson(model)));
    return PreferitiState(listaPreferiti: preferiti);
    //TODO aggiorna la lista sulla local datasource
  }

  @override
  Map<String, dynamic>? toJson(PreferitiState state) {
    final result = <String, dynamic>{};
    final listaPreferiti = [];
    for (var preferito in state.listaPreferiti) {
      listaPreferiti.add(preferito.toJson());
    }
    result.addAll({'listaPreferiti': listaPreferiti});
    //TODO aggiorna la lista sulla local datasource

    return result;
  }
}
