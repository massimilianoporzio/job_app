part of 'aziende_filter_cubit.dart';

class AziendeFilterState extends Equatable {
  final String searchTerm;
  final bool juniorSeniorityFilter;
  final bool midSeniorityFilter;
  final bool seniorSeniorityFilter;

  const AziendeFilterState({
    required this.searchTerm,
    required this.juniorSeniorityFilter,
    required this.midSeniorityFilter,
    required this.seniorSeniorityFilter,
  });

  int get numberOfActiveFilters {
    int result = 0;
    if (juniorSeniorityFilter) result++;
    if (midSeniorityFilter) result++;
    if (seniorSeniorityFilter) result++;
    if (searchTerm.isNotEmpty) result++;
    return result;
  }

  bool get isSeniorityEmpty {
    if (juniorSeniorityFilter || midSeniorityFilter || seniorSeniorityFilter) {
      return false;
    }
    return true;
  }

  bool get isEmpty {
    if (!isSeniorityEmpty || searchTerm.isNotEmpty) {
      return false;
    }
    return true;
  }

  factory AziendeFilterState.initial() => const AziendeFilterState(
      searchTerm: "",
      juniorSeniorityFilter: false,
      midSeniorityFilter: false,
      seniorSeniorityFilter: false);

  @override
  List<Object?> get props => [
        searchTerm,
        juniorSeniorityFilter,
        midSeniorityFilter,
        seniorSeniorityFilter
      ];
  @override
  bool? get stringify => true;

  AziendeFilterState copyWith({
    String? searchTerm,
    bool? juniorSeniorityFilter,
    bool? midSeniorityFilter,
    bool? seniorSeniorityFilter,
  }) {
    return AziendeFilterState(
      searchTerm: searchTerm ?? this.searchTerm,
      juniorSeniorityFilter:
          juniorSeniorityFilter ?? this.juniorSeniorityFilter,
      midSeniorityFilter: midSeniorityFilter ?? this.midSeniorityFilter,
      seniorSeniorityFilter:
          seniorSeniorityFilter ?? this.seniorSeniorityFilter,
    );
  }
}
