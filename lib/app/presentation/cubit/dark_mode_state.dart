part of 'dark_mode_cubit.dart';

class DarkModeState extends Equatable {
  final ThemeMode mode;

  const DarkModeState({
    required this.mode,
  });

  factory DarkModeState.initial() {
    var state = const DarkModeState(mode: ThemeMode.light);
    return state;
  }

  @override
  String toString() => 'DarkModeState(mode: $mode)';

  @override
  List<Object> get props => [mode];

  DarkModeState copyWith({
    ThemeMode? mode,
  }) {
    return DarkModeState(
      mode: mode ?? this.mode,
    );
  }
}
