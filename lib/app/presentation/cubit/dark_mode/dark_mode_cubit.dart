import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeState.initial());

  void toggleDarkMode() {
    emit(state.copyWith(
        mode:
            state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light));
  }
}
