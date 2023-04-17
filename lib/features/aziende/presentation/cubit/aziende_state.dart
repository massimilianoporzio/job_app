part of 'aziende_cubit.dart';

abstract class AziendeState extends Equatable {
  const AziendeState();

  @override
  List<Object> get props => [];
}

class AziendeStateInitial extends AziendeState {
  final List<RichTextTextEntity> listaAnnunci;
  const AziendeStateInitial({
    this.listaAnnunci = const [],
  });
}

class AziendeStateLoaded extends AziendeState {
  final List<RichTextTextEntity> listaAnnunci;
  const AziendeStateLoaded({
    required this.listaAnnunci,
  });
}

class AziendeStateError extends AziendeState {
  final String message;
  const AziendeStateError({required this.message});
}
