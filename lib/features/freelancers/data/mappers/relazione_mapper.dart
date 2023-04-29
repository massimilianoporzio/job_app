import 'package:job_app/core/data/mappers/base_mapper.dart';
import 'package:job_app/features/freelancers/data/models/relazione_model.dart';
import 'package:job_app/features/freelancers/domain/entities/relazione_entity.dart';

class RelazioneMapper extends EntityMapper<RelazioneModel?, RelazioneEntity?> {
  @override
  RelazioneModel? fromEntity(RelazioneEntity? entity) {
    // TODO: implement fromEntity
    throw UnimplementedError();
  }

  @override
  RelazioneEntity? toEntity(RelazioneModel? model) {
    if (model == null) {
      return null;
    } else {
      return RelazioneEntity(
        relazione: model.relazione,
        backgroundColorString: model.backgroundColorString,
      );
    }
  }
}
