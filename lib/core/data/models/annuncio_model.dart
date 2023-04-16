import 'dart:convert';

import 'package:job_app/core/data/models/rich_text_model.dart';
import 'package:job_app/core/data/models/seniority_model.dart';
import 'package:job_app/core/data/models/team_model.dart';
import 'package:job_app/core/data/models/weblink_model.dart';
import 'package:job_app/core/domain/entities/annuncio.dart';

import 'contratto_model.dart';

class AnnuncioModel extends Annuncio {
  const AnnuncioModel(
      {required super.id,
      required super.titolo,
      super.qualifica,
      required super.nomeAzienda,
      super.team,
      super.contratto,
      super.seniority,
      super.retribuzione,
      required super.descrizioneOfferta,
      required super.comeCandidarsi,
      super.localita,
      super.emoji,
      required super.jobPosted,
      required super.archived})
      : assert(team is TeamModel),
        assert(contratto is ContrattoModel),
        assert(seniority is SeniorityModel),
        assert(descrizioneOfferta is List<List<RichTextModel>>),
        assert(comeCandidarsi is WebLinkModel);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'titolo': titolo});
    if (qualifica != null) {
      result.addAll({'qualifica': qualifica});
    }
    result.addAll({'nomeAzienda': nomeAzienda});
    if (team != null) {
      result.addAll({'team': (team as TeamModel).toMap()});
    }
    if (contratto != null) {
      result.addAll({'contratto': (contratto as ContrattoModel).toMap()});
    }
    if (seniority != null) {
      result.addAll({'seniority': (seniority as SeniorityModel).toMap()});
    }
    if (retribuzione != null) {
      result.addAll({'retribuzione': retribuzione});
    }
    result.addAll({
      'descrizioneOfferta': (descrizioneOfferta as List<RichTextModel>)
          .map((x) => x.toMap())
          .toList()
    });
    result.addAll({'comeCandidarsi': (comeCandidarsi as WebLinkModel).toMap()});
    if (localita != null) {
      result.addAll({'localita': localita});
    }
    if (emoji != null) {
      result.addAll({'emoji': emoji});
    }
    result.addAll({'jobPosted': jobPosted.millisecondsSinceEpoch});
    result.addAll({'archived': archived});

    return result;
  }

  factory AnnuncioModel.fromJson(Map<String, dynamic> map) {
    return AnnuncioModel(
      id: map['id'] ?? '',
      titolo: map['titolo'] ?? '',
      qualifica: map['qualifica'],
      nomeAzienda: map['nomeAzienda'] ?? '',
      team: map["team"] != null ? TeamModel.fromJson(map["team"]) : null,
      contratto: map['contratto'] != null
          ? ContrattoModel.fromJson(map['contratto'])
          : null,
      seniority: map['seniority'] != null
          ? SeniorityModel.fromJson(map['seniority'])
          : null,
      retribuzione: map['retribuzione'],
      descrizioneOfferta: List<RichTextModel>.from(
          map['descrizioneOfferta']?.map((x) => RichTextModel.fromJson(x))),
      comeCandidarsi: WebLinkModel.fromJson(map['comeCandidarsi']),
      localita: map['localita'],
      emoji: map['emoji'],
      jobPosted: DateTime.fromMillisecondsSinceEpoch(map['jobPosted']),
      archived: map['archived'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());
}
