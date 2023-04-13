import 'package:equatable/equatable.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import 'package:job_app/app/resources/enums/contratto.dart';
import 'package:job_app/app/resources/enums/seniority.dart';
import 'package:job_app/app/resources/enums/team.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/core/domain/entities/weblink.dart';

class Annuncio extends Equatable {
  final String id;
  final String titolo;
  final String? qualifica;
  final String nomeAzienda;
  final Team? team;
  final Contratto? contratto;
  final Seniority? seniority;
  final String? retribuzione;
  final List<RichTextTextEntity> descrizioneOfferta;
  final Weblink comeCandidarsi;
  final String localita;
  final Emoji? emoji;
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
    required this.localita,
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
}
