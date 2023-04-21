import 'package:job_app/core/data/mappers/base_mapper.dart';
import 'package:job_app/core/data/mappers/rich_text_mapper.dart';
import 'package:job_app/core/data/models/annuncio_model.dart';
import 'package:job_app/core/domain/entities/annuncio.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';

import '../../domain/entities/weblink.dart';
import 'contratto_mapper.dart';
import 'seniority_mapper.dart';
import 'team_mapper.dart';

final _teamMapper = TeamMapper();
final _contrattoMapper = ContrattoMapper();
final _seniorityMapper = SeniorityMapper();

final _modelToEntityMapper = AnnuncioMapper();

class AnnuncioMapper extends EntityMapper<AnnuncioModel, Annuncio> {
  @override
  AnnuncioModel fromEntity(Annuncio entity) {
    // TODO: implement fromEntity
    throw UnimplementedError();
  }

  @override
  Annuncio toEntity(AnnuncioModel model) {
    return Annuncio(
      id: model.id,
      titolo: model.titolo,
      qualifica: model.qualifica,
      nomeAzienda: Weblink(
        content: model.nomeAzienda.content,
        url: model.nomeAzienda.url,
      ),
      team: _teamMapper.toEntity(model.team),
      contratto: _contrattoMapper.toEntity(model.contratto),
      seniority: _seniorityMapper.toEntity(model.seniority),
      retribuzione: model.retribuzione,
      descrizioneOfferta: model.descrizioneOfferta.richTextList,
      comeCandidarsi: Weblink(
        content: model.comeCandidarsi.content,
        url: model.comeCandidarsi.url,
      ),
      localita: model.localita,
      emoji: model.emoji,
      jobPosted: model.jobPosted,
      archived: model.archived,
      tipoAnnuncio: model.tipoAnnuncio,
    );
  }
}

extension AnnuncioExt on List<AnnuncioModel> {
  AnnuncioList get annuncioList =>
      map((e) => _modelToEntityMapper.toEntity(e)).toList();
}
