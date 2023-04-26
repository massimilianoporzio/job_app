import 'package:job_app/core/data/mappers/base_mapper.dart';
import 'package:job_app/core/data/mappers/rich_text_mapper.dart';

import 'package:job_app/core/domain/entities/annuncio.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';

import '../../../../core/domain/entities/weblink.dart';
import '../../data/models/annuncio_azienda_model.dart';
import '../../../../core/data/mappers/contratto_mapper.dart';
import '../../../../core/data/mappers/seniority_mapper.dart';
import '../../../../core/data/mappers/team_mapper.dart';

final _teamMapper = TeamMapper();
final _contrattoMapper = ContrattoMapper();
final _seniorityMapper = SeniorityMapper();

final _modelToEntityMapper = AnnuncioMapper();

class AnnuncioMapper
    extends EntityMapper<AnnuncioAziendaModel, AnnuncioAzienda> {
  @override
  AnnuncioAziendaModel fromEntity(AnnuncioAzienda entity) {
    // TODO: implement fromEntity
    throw UnimplementedError();
  }

  @override
  AnnuncioAzienda toEntity(AnnuncioAziendaModel model) {
    return AnnuncioAzienda(
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
      urlAnnuncio: model.urlAnnuncio != null
          ? Weblink(
              content: model.urlAnnuncio!.content, url: model.urlAnnuncio!.url)
          : null,
    );
  }
}

extension AnnuncioExt on List<AnnuncioAziendaModel> {
  AnnuncioAziendaList get annuncioList =>
      map((e) => _modelToEntityMapper.toEntity(e)).toList();
}
