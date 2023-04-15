import 'dart:convert';
import 'dart:io';

import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/app/resources/app_consts.dart';
import 'package:job_app/app/resources/enums/seniority.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:job_app/core/domain/entities/rich_text_annotation.dart';
import 'package:loggy/loggy.dart';

import '../../app/resources/enums/contratto.dart';

import '../../app/resources/enums/team.dart';
import '../domain/entities/annuncio.dart';
import '../domain/entities/contratto_entity.dart';
import '../domain/entities/rich_text_entity.dart';
import '../domain/entities/seniority_enitity.dart';
import '../domain/entities/team_entity.dart';
import '../domain/entities/weblink.dart';

// import 'package:easy_rich_text/easy_rich_text.dart';

void main() async {
  var input = await File('dummy_annunci.json').readAsString();
  var response = json.decode(input);
  var emojiParser = EmojiParser();
  List results = response['results'];
  List<Annuncio> listaAnnunci = [];
  if (results.isNotEmpty) {
    for (Map<String, dynamic> annuncio in results) {
      final String id = annuncio['id'];
      Emoji? emoji;
      TeamEntity? team;
      ContrattoEntity? contratto;
      SeniorityEntity? seniority;
      final String titolo;
      String? qualifica;
      String? retribuzione;
      final List<RichTextTextEntity> descrizioneOfferta = [];
      final Weblink comeCandidarsi;
      String? localita;
      final String nomeAzienda;

      if (annuncio.containsKey("icon")) {
        if (annuncio["icon"]["type"] == "emoji") {
          try {
            emoji = emojiParser.getEmoji(annuncio["icon"]["emoji"]);
          } on Exception {
            logError("Error in parsing emoji");
          }
        }
      }
      //default false
      final bool archived = annuncio.containsKey("archived")
          ? annuncio["archived"] as bool
          : false;
      Map<String, dynamic> properties = annuncio["properties"];
      final DateTime jobPosted =
          DateTime.parse(properties["Job Posted"]["created_time"] as String);
      if (properties.containsKey("Team")) {
        Map<String, dynamic> mapTeam =
            properties["Team"] as Map<String, dynamic>;
        if (mapTeam.containsKey("select")) {
          if (mapTeam["select"] != null) {
            String teamName = mapTeam["select"]["name"] as String;
            String teamColor = mapTeam["select"]["color"] as String;

            if (AppConsts.notionTeams.contains(teamName)) {
              switch (teamName) {
                case StringConsts.notionTeamInSede:
                  team = TeamEntity(
                      team: Team.inSede, backgroundColorString: teamColor);
                  break;
                case StringConsts.notionTeamIbrido:
                  team = TeamEntity(
                      team: Team.ibrido, backgroundColorString: teamColor);
                  break;
                case StringConsts.notionTeamFullRemote:
                  team = TeamEntity(
                      team: Team.fullRemote, backgroundColorString: teamColor);
                  break;
                default:
              }
            }
          }
        }
      } //fine parsing di Team
      if (properties.containsKey("Contratto")) {
        Map<String, dynamic> mapContratto =
            properties["Contratto"] as Map<String, dynamic>;
        if (mapContratto.containsKey("select")) {
          if (mapContratto["select"] != null) {
            if (mapContratto["select"] != null) {
              String contrattoName = mapContratto["select"]["name"] as String;
              String contrattoColor = mapContratto["select"]["color"] as String;

              switch (contrattoName) {
                case StringConsts.notionContrattoFullTime:
                  contratto = ContrattoEntity(
                      contratto: Contratto.fullTime,
                      backgroundColorString: contrattoColor);
                  break;
                case StringConsts.notionContrattoPartTime:
                  contratto = ContrattoEntity(
                      contratto: Contratto.partTime,
                      backgroundColorString: contrattoColor);
                  break;

                default:
              }
            }
          }
        }
      } //fine parsing di Contratto
      if (properties.containsKey("Seniority")) {
        Map<String, dynamic> mapSeniority =
            properties["Seniority"] as Map<String, dynamic>;
        if (mapSeniority.containsKey("select")) {
          if (mapSeniority["select"] != null) {
            String seniorityName = mapSeniority["select"]["name"] as String;
            String seniorityColor = mapSeniority["select"]["color"] as String;
            switch (seniorityName) {
              case StringConsts.notionSeniorityJunior:
                seniority = SeniorityEntity(
                    seniority: Seniority.junior,
                    backgroundColorString: seniorityColor);
                break;
              case StringConsts.notionSeniorityMid:
                seniority = SeniorityEntity(
                    seniority: Seniority.mid,
                    backgroundColorString: seniorityColor);
                break;
              case StringConsts.notionSenioritySenior:
                seniority = SeniorityEntity(
                    seniority: Seniority.senior,
                    backgroundColorString: seniorityColor);
                break;
              default:
            }
          }
        }
      } //fine parsing Seniority
      //parsing "Name"
      titolo = properties["Name"]["title"]["plain_text"] as String;
      //parsing "Qualifica"
      if (properties.containsKey("Qualifica")) {
        qualifica =
            properties["Qualifica"]["rich_text"]["plain_text"] as String;
      } //fine parsing Qualifica
      //parsing "Retrubizione"
      if (properties.containsKey("Retribuzione")) {
        retribuzione =
            properties["Retribuzione"]["rich_text"]["plain_text"] as String;
      }
      //fine parsing retribuzione
      //*DESCRIZIONE OFFERTA - RICHTEXT
      if (properties.containsKey("Descrizione offerta")) {
        List<dynamic> richText = properties["Descrizione offerta"]["rich_text"];

        //Giro la lista dei "token" da cui è composta la descr dell'offerta
        for (var token in richText) {
          //la prendo come mappa perché nel json è così
          token = token as Map<String, dynamic>;
          //per ora prendo solo i rich text di tipo testo
          if (token['type'] == "text") {
            String tokenPlainText = token["plain_text"] as String;
            RichTextAnnotation annotations = RichTextAnnotation(
                bold: token["annotations"]["bold"] as bool,
                italic: token["annotations"]["italic"] as bool,
                strikethrough: token["annotations"]["strikethrough"] as bool,
                underline: token["annotations"]["underline"] as bool,
                code: token["annotations"]["code"] as bool,
                colorString: token["annotations"]["color"] as String?);
            descrizioneOfferta.add(RichTextTextEntity(
              plainText: tokenPlainText,
              annotation: annotations,
            ));
          } //fine if se il rich text è di tipo text
        } //fine giro dei token dell'offerta
      } //fine parsing descrizione offerta come rich text

      comeCandidarsi = Weblink(
          content: properties["Come candidarsi"]["rich_text"]["plain_text"]
              as String,
          url: properties["Come candidarsi"]["rich_text"]["href"] as String);
      //fine parsing come candidarsi
      if (properties.containsKey("Località")) {
        localita = properties["Località"]["rich_text"]["plain_text"] as String?;
      } //fine parsing località
      nomeAzienda =
          properties["Nome azienda"]["rich_text"]["plain_text"] as String;

      //*ora creo l'annuncio

      listaAnnunci.add(Annuncio(
        id: id,
        titolo: titolo,
        nomeAzienda: nomeAzienda,
        descrizioneOfferta: descrizioneOfferta,
        comeCandidarsi: comeCandidarsi,
        jobPosted: jobPosted,
        archived: archived,
        contratto: contratto,
        emoji: emoji,
        localita: localita,
        qualifica: qualifica,
        retribuzione: retribuzione,
        seniority: seniority,
        team: team,
      ));
    } //fine giro sugli annunci "results"
  } //fine if se result non è vuoto
  logDebug(listaAnnunci);
} //fine main
