import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class AnnunciAzParams extends Equatable {
  final String? annuncioId;
  //SERVE PER I FILTRI
  final String? searchTerm;

  const AnnunciAzParams({this.searchTerm, this.annuncioId});

  @override
  List<Object?> get props => [searchTerm, annuncioId];

  AnnunciAzParams copyWith({
    String? searchTerm,
    String? annuncioId,
  }) {
    return AnnunciAzParams(
      searchTerm: searchTerm ?? this.searchTerm,
      annuncioId: annuncioId ?? this.annuncioId,
    );
  }
}
