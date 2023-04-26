import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/core/domain/entities/typedefs.dart';
import 'package:job_app/core/domain/enums/tipologia_annunci.dart';
import 'package:loggy/loggy.dart';

import '../../app/resources/app_consts.dart';
import '../../app/resources/string_constants.dart';
import '../domain/entities/annuncio.dart';
import '../domain/entities/contratto_entity.dart';
import '../domain/entities/rich_text_annotation.dart';
import '../domain/entities/rich_text_entity.dart';
import '../domain/entities/seniority_enitity.dart';
import '../domain/entities/team_entity.dart';
import '../domain/entities/weblink.dart';
import '../domain/enums/contratto.dart';
import '../domain/enums/seniority.dart';
import '../domain/enums/team.dart';
import '../services/service_locator.dart';

import 'package:easy_rich_text/easy_rich_text.dart';

EasyRichText getWidgetFromRichTextEntity(RichTextList richTextList) {
  String plainText = '';
  var patternList = <EasyRichTextPattern>[];
  for (var richTextEntity in richTextList) {
    if (richTextEntity.plainText.isNotEmpty) {
      plainText += richTextEntity.plainText;
      if (!richTextEntity.annotation.isPlain()) {
        var annotation = richTextEntity.annotation;
        var listDecoration = <TextDecoration>[];
        if (annotation.strikethrough) {
          listDecoration.add(TextDecoration.lineThrough);
        }
        if (annotation.underline) {
          listDecoration.add(TextDecoration.underline);
        }
        var listFeatures = <FontFeature>[];
        if (annotation.code) {
          listFeatures.add(const FontFeature.tabularFigures());
        }
        var style = TextStyle(
          fontWeight: annotation.bold ? FontWeight.bold : FontWeight.normal,
          fontStyle: annotation.italic ? FontStyle.italic : FontStyle.normal,
          decoration: TextDecoration.combine(listDecoration),
          fontFeatures: listFeatures,
        );

        patternList.add(EasyRichTextPattern(
            hasSpecialCharacters: true,
            targetString: richTextEntity.plainText,
            style: style));
      }
    }
  }
  plainText += "\n\n\n\n\n\n";

  var result = EasyRichText(
    plainText,
    textAlign: TextAlign.left,
    patternList: patternList,
  );
  return result;
}

void main() async {
  final dio = sl<Dio>();
  final response2 =
      await dio.post(StringConsts.baseUrlAziende, data: {"page_size": 2});

  print(response2.data);

  var input = await File('dummy_annunci.json').readAsString();
  var response = json.decode(input);
  var emojiParser = EmojiParser();
  List results = response['results'];
  List<AnnuncioAzienda> listaAnnunci = [];
  if (results.isNotEmpty) {
    for (Map<String, dynamic> annuncio in results) {
      final String id = annuncio['id'];
      String? emoji;
      TeamEntity? team;
      ContrattoEntity? contratto;
      SeniorityEntity? seniority;
      final String titolo;
      String? qualifica;
      String? retribuzione;
      final List<RichTextTextEntity> descrizioneOfferta = [];
      Weblink comeCandidarsi;
      String? localita;
      final Weblink nomeAzienda;

      if (annuncio.containsKey("icon")) {
        if (annuncio["icon"]["type"] == "emoji") {
          try {
            emoji = emojiParser.getEmoji(annuncio["icon"]["emoji"]).name;
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
      titolo = properties["Name"]["title"][0]["plain_text"] as String;
      //parsing "Qualifica"
      if (properties.containsKey("Qualifica")) {
        if ((properties["Qualifica"]["rich_text"] as List).isNotEmpty) {
          qualifica =
              properties["Qualifica"]["rich_text"][0]["plain_text"] as String;
        }
      } //fine parsing Qualifica
      //parsing "Retrubizione"
      if (properties.containsKey("Retribuzione")) {
        if ((properties["Retribuzione"]["rich_text"] as List).isNotEmpty) {
          retribuzione = properties["Retribuzione"]["rich_text"][0]
              ["plain_text"] as String;
        }
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
      String? urlComeCandiarsi;
      if (properties["Come candidarsi"]["rich_text"][0]["href"] != null) {
        urlComeCandiarsi =
            properties["Come candidarsi"]["rich_text"][0]["href"] as String;
      }
      comeCandidarsi = Weblink(
        content: properties["Come candidarsi"]["rich_text"][0]["plain_text"]
            as String,
        url: urlComeCandiarsi,
      );

      //fine parsing come candidarsi
      if (properties.containsKey("Località")) {
        if ((properties["Località"]["rich_text"] as List).isNotEmpty) {
          localita =
              properties["Località"]["rich_text"][0]["plain_text"] as String?;
        }
      } //fine parsing località
      String? urlAzienda;
      if (properties["Nome azienda"]["rich_text"][0]["href"] != null) {
        urlAzienda =
            properties["Nome azienda"]["rich_text"][0]["href"] as String;
      }
      nomeAzienda = Weblink(
          content: properties["Nome azienda"]["rich_text"][0]["plain_text"]
              as String,
          url: urlAzienda);

      //*ora creo l'annuncio

      listaAnnunci.add(AnnuncioAzienda(
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
