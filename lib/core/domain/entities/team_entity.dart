import '../../../app/resources/enums/team.dart';

class TeamEntity {
  final Team team;
  final String? backgroundColorString;

  TeamEntity({
    required this.team,
    this.backgroundColorString,
  });
}
