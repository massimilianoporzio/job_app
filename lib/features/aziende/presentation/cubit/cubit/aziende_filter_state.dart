part of 'aziende_filter_cubit.dart';

class AziendeFilterState extends Equatable {
  final String? searchTerm;
  final bool juniorSeniorityFilter;
  final bool midSeniorityFilter;
  final bool seniorSeniorityFilter;

  const AziendeFilterState({
    this.searchTerm,
    required this.juniorSeniorityFilter,
    required this.midSeniorityFilter,
    required this.seniorSeniorityFilter,
  });

  bool get isEmpty {
    if (juniorSeniorityFilter || midSeniorityFilter || seniorSeniorityFilter) {
      return false;
    }
    return true;
  }

  factory AziendeFilterState.initial() => const AziendeFilterState(
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
