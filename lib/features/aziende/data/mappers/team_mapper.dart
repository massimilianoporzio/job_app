import 'package:job_app/core/data/mappers/base_mapper.dart';

import '../../domain/entities/team_entity.dart';
import '../models/team_model.dart';

class TeamMapper extends EntityMapper<TeamModel?, TeamEntity?> {
  @override
  TeamModel? fromEntity(TeamEntity? entity) {
    // TODO: implement fromEntity
    throw UnimplementedError();
  }

  @override
  TeamEntity? toEntity(TeamModel? model) {
    if (model == null) {
      return null;
    } else {
      return TeamEntity(
        team: model.team,
        backgroundColorString: model.backgroundColorString,
      );
    }
  }
}
