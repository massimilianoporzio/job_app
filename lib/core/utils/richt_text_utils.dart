import 'dart:convert';
import 'dart:io';

import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/app/resources/app_consts.dart';
import 'package:job_app/app/resources/enums/seniority.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:loggy/loggy.dart';

import '../../app/resources/enums/contratto.dart';

import '../../app/resources/enums/team.dart';
import '../domain/entities/annuncio.dart';
import '../domain/entities/rich_text_entity.dart';
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
      final Emoji? emoji;
      final TeamEntity? team;
      final Contratto? contratto;
      final Seniority? seniority;
      final String titolo;
      final String? qualifica;
      final String? retribuzione;
      final List<RichTextTextEntity> descrizioneOfferta = [];
      final Weblink comeCandidarsi;
      final String localita;

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
            String contrattoName = mapContratto["select"]["name"] as String;
            switch (contrattoName) {
              case StringConsts.notionContrattoFullTime:
                contratto = Contratto.fullTime;
                break;
              case StringConsts.notionContrattoPartTime:
                contratto = Contratto.partTime;
                break;

              default:
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
            switch (seniorityName) {
              case StringConsts.notionSeniorityJunior:
                seniority = Seniority.junior;
                break;
              case StringConsts.notionSeniorityMid:
                seniority = Seniority.mid;
                break;
              case StringConsts.notionSenioritySenior:
                seniority = Seniority.senior;
                break;
              default:
            }
          }
        }
      } //fine parsing Seniority
      titolo = properties["Name"]["title"]["plain_text"];
      if (properties.containsKey("Qualifica")) {
        qualifica = properties["Qualifica"]["rich_text"]["plain_text"];
      } //fine parsing Qualifica
    } //fine giro sugli annunci "results"
  }
  var primoAnnuncio = results[0];
  var properties = primoAnnuncio['properties'];
  var descrizioneOfferta = properties['Descrizione offerta'];
  List<dynamic> richText = descrizioneOfferta["rich_text"];
  for (var token in richText) {
    if (token['type'] == "text") {
      String tokenString = token["text"]["content"];
      print(tokenString);
      print('---');
      // EasyRichTextPattern pattern = EasyRichTextPattern(targetString: targetString)
    }
  }
}

// Future<void> readJson() async {
//   final String response = await rootBundle.loadString('assets/sample.json');
//   final data = await jsonDecode(response);
//   // ...
// }

//da un elemento 'rich_text" di tipo Map<String,dynamic>
//mi resituisce il pattern da applicare
// List<EasyRichTextPattern> getPatternsFromAnnotations(
//     Map<String, dynamic> richTextT) {
//   List<EasyRichTextPattern> results = [];

//   return results;
// }
