part of 'aziende_cubit.dart';

abstract class AziendeState extends Equatable {
  const AziendeState();

  @override
  List<Object> get props => [];
}

class AziendeStateInitial extends AziendeState {
  final AnnuncioList listaAnnunci;
  const AziendeStateInitial({
    this.listaAnnunci = const [],
  });
}

class AziendeStateLoading extends AziendeState {}

class AziendeStateNoConnection extends AziendeState {}

class AziendeStateLoaded extends AziendeState with UiLoggy {
  final AnnuncioList listaAnnunci;
  const AziendeStateLoaded({
    required this.listaAnnunci,
  });

  String get numeroAnnunciRecenti {
    if (listaAnnunci.isEmpty) {
      return "0";
    }
    int numAnnunciRecenti = 0;
    for (var annuncio in listaAnnunci) {
      var oggi = DateTime.now();
      var dataAnnuncio = annuncio.jobPosted;
      loggy.debug("dataAnnuncio: $dataAnnuncio");
      int giorniDiDifferenza = oggi.difference(dataAnnuncio).inDays;
      if (giorniDiDifferenza < 7) {
        numAnnunciRecenti += 1;
      }
    }
    return numAnnunciRecenti.toString();
  }

  String get numeroAziende {
    if (listaAnnunci.isEmpty) {
      return "0";
    }
    Set<String> setAziende = {};
    for (var annuncio in listaAnnunci) {
      setAziende.add(annuncio.nomeAzienda);
    }
    return setAziende.length.toString();
  }
}

class AziendeStateError extends AziendeState {
  final String message;
  const AziendeStateError({required this.message});
}
