import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/app/resources/app_consts.dart';
import 'package:job_app/app/resources/enums/seniority.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:loggy/loggy.dart';

import '../domain/app_enums.dart';
import '../domain/entities/annuncio.dart';

// import 'package:easy_rich_text/easy_rich_text.dart';

void main() async {
  print("prova: ");
  print(Seniority.junior.compareTo(Seniority.mid));
  var input = await File('dummy_annunci.json').readAsString();
  var response = json.decode(input);
  var emojiParser = EmojiParser();
  List results = response['results'];
  List<Annuncio> listaAnnunci = [];
  if (results.isNotEmpty) {
    for (Map<String, dynamic> annuncio in results) {
      String id = annuncio['id'];
      Emoji? emoji;
      Team? team;
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
      bool archived = annuncio.containsKey("archived")
          ? annuncio["archived"] as bool
          : false;
      Map<String, dynamic> properties = annuncio["properties"];
      DateTime jobPosted =
          DateTime.parse(properties["Job Posted"]["created_time"] as String);
      if (properties.containsKey("Team")) {
        Map<String, dynamic> mapTeam =
            properties["Team"] as Map<String, dynamic>;
        if (mapTeam.containsKey("select")) {
          String teamName = mapTeam["select"]["name"] as String;
          if (AppConsts.notionTeams.contains(teamName)) {
            switch (teamName) {
              case StringConsts.notionTeamInSede:
                team = Team.inSede;
                break;
              case StringConsts.notionTeamIbrido:
                team = Team.ibrido;
                break;
              case StringConsts.notionTeamFullRemote:
                team = Team.fullRemote;
                break;
              default:
            }
          }
        }
      } //fine definizione di Team
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
