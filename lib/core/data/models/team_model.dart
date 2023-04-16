import 'dart:convert';

import 'package:job_app/core/domain/entities/team_entity.dart';

import '../../domain/enums/team.dart';

class TeamModel extends TeamEntity {
  const TeamModel({
    required super.team,
    required backgroundColorString,
  });
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'team': team.toJson()});
    if (backgroundColorString != null) {
      result.addAll({'backgroundColorString': backgroundColorString});
    }

    return result;
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      team: Team.fromJson(json['team']),
      backgroundColorString: json['backgroundColorString'],
    );
  }
}
