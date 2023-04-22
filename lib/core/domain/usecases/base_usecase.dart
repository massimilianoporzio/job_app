import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class AnnunciAzParams extends Equatable {
  //SERVE PER I FILTRI
  final String? searchTerm;

  const AnnunciAzParams({this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}
