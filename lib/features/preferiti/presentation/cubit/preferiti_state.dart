part of 'preferiti_cubit.dart';

enum PreferitiStatus {
  loading,
  loaded,
  error;

  String toJson() => name;
  static PreferitiStatus fromJson(String json) => values.byName(json);
}

class PreferitiState extends Equatable {
  final List<Annuncio> listaPreferiti;
  final String? message;
  final PreferitiStatus status;

  factory PreferitiState.initial() {
    return const PreferitiState(
      listaPreferiti: [],
      status: PreferitiStatus.loading,
    );
  }

  const PreferitiState({
    required this.listaPreferiti,
    this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [
        listaPreferiti,
        message,
        status,
      ];

  PreferitiState copyWith({
    List<Annuncio>? listaPreferiti,
    String? message,
    PreferitiStatus? status,
  }) {
    return PreferitiState(
      listaPreferiti: listaPreferiti ?? this.listaPreferiti,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
