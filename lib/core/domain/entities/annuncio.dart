import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:job_app/core/domain/entities/contratto_entity.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/core/domain/entities/seniority_enitity.dart';
import 'package:job_app/core/domain/entities/weblink.dart';

import 'team_entity.dart';

class Annuncio extends Equatable {
  final String id;
  final String titolo;
  final String? qualifica;
  final String nomeAzienda;
  final TeamEntity? team;
  final ContrattoEntity? contratto;
  final SeniorityEntity? seniority;
  final String? retribuzione;
  final List<RichTextTextEntity> descrizioneOfferta;
  final Weblink comeCandidarsi;
  final String? localita;
  final String? emoji;
  final DateTime jobPosted;
  final bool archived;

  const Annuncio({
    required this.id,
    required this.titolo,
    this.qualifica,
    required this.nomeAzienda,
    this.team,
    this.contratto,
    this.seniority,
    this.retribuzione,
    required this.descrizioneOfferta,
    required this.comeCandidarsi,
    this.localita,
    this.emoji,
    required this.jobPosted,
    required this.archived,
  });

  @override
  List<Object?> get props {
    return [
      id,
      titolo,
      qualifica,
      nomeAzienda,
      team,
      contratto,
      seniority,
      retribuzione,
      descrizioneOfferta,
      comeCandidarsi,
      localita,
      emoji,
      jobPosted,
      archived,
    ];
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'titolo': titolo});
    if (qualifica != null) {
      result.addAll({'qualifica': qualifica});
    }
    result.addAll({'nomeAzienda': nomeAzienda});
    if (team != null) {
      result.addAll({'team': team!.toMap()});
    }
    if (contratto != null) {
      result.addAll({'contratto': contratto!.toMap()});
    }
    if (seniority != null) {
      result.addAll({'seniority': seniority!.toMap()});
    }
    if (retribuzione != null) {
      result.addAll({'retribuzione': retribuzione});
    }
    result.addAll({
      'descrizioneOfferta': descrizioneOfferta.map((x) => x.toMap()).toList()
    });
    result.addAll({'comeCandidarsi': comeCandidarsi.toMap()});
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

  factory Annuncio.fromMap(Map<String, dynamic> map) {
    return Annuncio(
      id: map['id'] ?? '',
      titolo: map['titolo'] ?? '',
      qualifica: map['qualifica'],
      nomeAzienda: map['nomeAzienda'] ?? '',
      team: map['team'] != null ? TeamEntity.fromJson(map['team']) : null,
      contratto: map['contratto'] != null
          ? ContrattoEntity.fromJson(map['contratto'])
          : null,
      seniority: map['seniority'] != null
          ? SeniorityEntity.fromJson(map['seniority'])
          : null,
      retribuzione: map['retribuzione'],
      descrizioneOfferta: List<RichTextTextEntity>.from(
          map['descrizioneOfferta']
              ?.map((x) => RichTextTextEntity.fromJson(x))),
      comeCandidarsi: Weblink.fromJson(map['comeCandidarsi']),
      localita: map['localita'],
      emoji: map['emoji'],
      jobPosted: DateTime.fromMillisecondsSinceEpoch(map['jobPosted']),
      archived: map['archived'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Annuncio.fromJson(String source) =>
      Annuncio.fromMap(json.decode(source));
}
