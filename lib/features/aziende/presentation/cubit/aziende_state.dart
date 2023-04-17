part of 'aziende_cubit.dart';

abstract class AziendeState extends Equatable {
  final List<RichTextTextEntity> listaAnnunci;
  const AziendeState({required this.listaAnnunci});

  @override
  List<Object> get props => [];
}

class AziendeStateInitial extends AziendeState {
  const AziendeStateInitial({super.listaAnnunci = const []});
}

class AziendeStateLoaded extends AziendeState {
  const AziendeStateLoaded({required super.listaAnnunci});
}
