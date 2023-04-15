import 'package:equatable/equatable.dart';
import 'package:job_app/core/utils/mixins.dart';

import '../../../app/resources/enums/team.dart';

class TeamEntity extends Equatable with NotionColor {
  final Team team;
  final String? backgroundColorString;

  const TeamEntity({
    required this.team,
    this.backgroundColorString,
  });

  @override
  List<Object> get props => [team];

  @override
  bool? get stringify => true;

  // Map<String, dynamic> toJson() {
  //   final result = <String, dynamic>{};

  //   result.addAll({'team': team.toJson()});
  //   if (backgroundColorString != null) {
  //     result.addAll({'backgroundColorString': backgroundColorString});
  //   }

  //   return result;
  // }

  // factory TeamEntity.fromJson(Map<String, dynamic> json) {
  //   return TeamEntity(
  //     team: Team.fromJson(json['team']),
  //     backgroundColorString: json['backgroundColorString'],
  //   );
  // }
}
