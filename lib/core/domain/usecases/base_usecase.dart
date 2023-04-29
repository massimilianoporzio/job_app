import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_app/features/aziende/presentation/cubit/filters/aziende_filter_cubit.dart';

import '../errors/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class AnnunciAzParams extends Equatable {
  final String? annuncioId;
  //SERVE PER I FILTRI
  final String searchTerm;
  final bool juniorSeniorityFilter;
  final bool midSeniorityFilter;
  final bool seniorSeniorityFilter;
  final bool fullTimeFilter;
  final bool partTimeFilter;
  final bool inSedeFilter;
  final bool ibridoFilter;
  final bool fullRemoteFilter;

  int get numberOfTypeOfFilter {
    int result = 0;
    if (!isSeniorityEmpty) result++;
    if (!isContrattoEmpty) result++;
    if (!isTeamEmpty) result++;
    if (searchTerm.isNotEmpty) result++;
    return result;
  }

  int get numberOfActiveFilters {
    int result = 0;
    if (juniorSeniorityFilter) result++;
    if (midSeniorityFilter) result++;
    if (seniorSeniorityFilter) result++;
    if (searchTerm.isNotEmpty) result++;
    if (partTimeFilter) result++;
    if (fullTimeFilter) result++;
    if (inSedeFilter) result++;
    if (fullRemoteFilter) result++;
    if (ibridoFilter) result++;
    return result;
  }

  bool get isSeniorityEmpty {
    if (juniorSeniorityFilter || midSeniorityFilter || seniorSeniorityFilter) {
      return false;
    }
    return true;
  }

  bool get isContrattoEmpty {
    if (fullTimeFilter || partTimeFilter) {
      return false;
    }
    return true;
  }

  bool get isTeamEmpty {
    if (inSedeFilter || ibridoFilter || fullRemoteFilter) {
      return false;
    }
    return true;
  }

  bool get isEmpty {
    if (searchTerm.isNotEmpty ||
        juniorSeniorityFilter ||
        midSeniorityFilter ||
        seniorSeniorityFilter ||
        fullTimeFilter ||
        partTimeFilter ||
        inSedeFilter ||
        ibridoFilter ||
        fullRemoteFilter) {
      return false;
    }
    return true;
  }

  factory AnnunciAzParams.empty() => const AnnunciAzParams();

  const AnnunciAzParams({
    this.annuncioId,
    this.searchTerm = "",
    this.juniorSeniorityFilter = false,
    this.midSeniorityFilter = false,
    this.seniorSeniorityFilter = false,
    this.fullTimeFilter = false,
    this.partTimeFilter = false,
    this.inSedeFilter = false,
    this.ibridoFilter = false,
    this.fullRemoteFilter = false,
  });

  @override
  List<Object?> get props {
    return [
      annuncioId,
      searchTerm,
      juniorSeniorityFilter,
      midSeniorityFilter,
      seniorSeniorityFilter,
      fullTimeFilter,
      partTimeFilter,
      inSedeFilter,
      ibridoFilter,
      fullRemoteFilter,
    ];
  }

  AnnunciAzParams copyWith({
    String? annuncioId,
    String? searchTerm,
    bool? juniorSeniorityFilter,
    bool? midSeniorityFilter,
    bool? seniorSeniorityFilter,
    bool? fullTimeFilter,
    bool? partTimeFilter,
    bool? inSedeFilter,
    bool? ibridoFilter,
    bool? fullRemoteFilter,
  }) {
    return AnnunciAzParams(
      annuncioId: annuncioId ?? this.annuncioId,
      searchTerm: searchTerm ?? this.searchTerm,
      juniorSeniorityFilter:
          juniorSeniorityFilter ?? this.juniorSeniorityFilter,
      midSeniorityFilter: midSeniorityFilter ?? this.midSeniorityFilter,
      seniorSeniorityFilter:
          seniorSeniorityFilter ?? this.seniorSeniorityFilter,
      fullTimeFilter: fullTimeFilter ?? this.fullTimeFilter,
      partTimeFilter: partTimeFilter ?? this.partTimeFilter,
      inSedeFilter: inSedeFilter ?? this.inSedeFilter,
      ibridoFilter: ibridoFilter ?? this.ibridoFilter,
      fullRemoteFilter: fullRemoteFilter ?? this.fullRemoteFilter,
    );
  }
}
