import 'package:job_app/core/data/mappers/base_mapper.dart';
import 'package:job_app/core/data/models/contratto_model.dart';
import 'package:job_app/core/domain/entities/contratto_entity.dart';

class ContrattoMapper extends EntityMapper<ContrattoModel?, ContrattoEntity?> {
  @override
  ContrattoModel? fromEntity(ContrattoEntity? entity) {
    // TODO: implement fromEntity
    throw UnimplementedError();
  }

  @override
  ContrattoEntity? toEntity(ContrattoModel? model) {
    if (model == null) {
      return null;
    } else {
      return ContrattoEntity(
        contratto: model.contratto,
        backgroundColorString: model.backgroundColorString,
      );
    }
  }
}
