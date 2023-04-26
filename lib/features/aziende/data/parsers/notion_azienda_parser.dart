import 'package:dio/dio.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:job_app/features/aziende/data/models/annuncio_azienda_model.dart';
import 'package:job_app/core/domain/errors/exceptions.dart';

import '../../../../app/resources/app_consts.dart';
import '../../../../app/resources/string_constants.dart';
import '../../../../core/data/models/contratto_model.dart';
import '../../../../core/data/models/rich_text_annotation_model.dart';
import '../../../../core/data/models/rich_text_model.dart';
import '../../../../core/data/models/seniority_model.dart';
import '../../../../core/data/models/team_model.dart';
import '../../../../core/data/models/weblink_model.dart';
import '../../../../core/domain/enums/contratto.dart';
import '../../../../core/domain/enums/seniority.dart';
import '../../../../core/domain/enums/team.dart';
import '../../../../core/domain/enums/tipologia_annunci.dart';

AnnuncioAziendaModel parseNotionResponseSingoloAnnuncio(
    Map<String, dynamic> annuncioNotion) {
  try {
    var emojiParser = EmojiParser();
    final String id = annuncioNotion['id'];
    String? emoji;
    TeamModel? team;
    ContrattoModel? contratto;
    SeniorityModel? seniority;
    final String titolo;
    String? qualifica;
    String? retribuzione;
    final List<RichTextModel> descrizioneOfferta = [];
    WebLinkModel comeCandidarsi;
    WebLinkModel? urlAnnuncio;
    String? localita;
    WebLinkModel nomeAzienda;
    final TipoAnnuncio tipoAnnuncio;

    if (annuncioNotion["parent"]["database_id"] ==
        StringConsts.notionDatabaseIdAziende) {
      tipoAnnuncio = TipoAnnuncio.aziende;
    } else {
      tipoAnnuncio = TipoAnnuncio.freelancers;
    }

    if (annuncioNotion.containsKey("icon")) {
      if (annuncioNotion["icon"]["type"] == "emoji") {
        try {
          emoji = emojiParser.getEmoji(annuncioNotion["icon"]["emoji"]).name;
        } on Exception {
          rethrow;
        }
      }
    } //fine se c'era l'icona
    //default false
    final bool archived = annuncioNotion.containsKey("archived")
        ? annuncioNotion["archived"] as bool
        : false;
    //*recupero le properties
    Map<String, dynamic> properties = annuncioNotion["properties"];
    //*data creazione annuncio
    final DateTime jobPosted =
        DateTime.parse(properties["Job Posted"]["created_time"] as String);
    //*TEAM
    if (properties.containsKey("Team")) {
      Map<String, dynamic> mapTeam = properties["Team"] as Map<String, dynamic>;
      if (mapTeam.containsKey("select")) {
        if (mapTeam["select"] != null) {
          String teamName = mapTeam["select"]["name"] as String;
          String teamColor = mapTeam["select"]["color"] as String;

          if (AppConsts.notionTeams.contains(teamName)) {
            switch (teamName) {
              case StringConsts.notionTeamInSede:
                team = TeamModel(
                    team: Team.inSede, backgroundColorString: teamColor);
                break;
              case StringConsts.notionTeamIbrido:
                team = TeamModel(
                    team: Team.ibrido, backgroundColorString: teamColor);
                break;
              case StringConsts.notionTeamFullRemote:
                team = TeamModel(
                    team: Team.fullRemote, backgroundColorString: teamColor);
                break;
              default:
            }
          } //fine parsing del team
        } //fine se la select del team era non null
      } //fine se team aveva la sua "select"
    } //fine parsing di Team
    //*CONTRATTO
    if (properties.containsKey("Contratto")) {
      Map<String, dynamic> mapContratto =
          properties["Contratto"] as Map<String, dynamic>;
      if (mapContratto.containsKey("select")) {
        if (mapContratto["select"] != null) {
          String contrattoName = mapContratto["select"]["name"] as String;
          String contrattoColor = mapContratto["select"]["color"] as String;

          switch (contrattoName) {
            case StringConsts.notionContrattoFullTime:
              contratto = ContrattoModel(
                  contratto: Contratto.fullTime,
                  backgroundColorString: contrattoColor);
              break;
            case StringConsts.notionContrattoPartTime:
              contratto = ContrattoModel(
                  contratto: Contratto.partTime,
                  backgroundColorString: contrattoColor);
              break;

            default:
          }
        } //fine se la select del contratto è non null
      } //fine se ho la select del contratto
    } //fine parsing di Contratto
    //*SENIORITY
    if (properties.containsKey("Seniority")) {
      Map<String, dynamic> mapSeniority =
          properties["Seniority"] as Map<String, dynamic>;
      if (mapSeniority.containsKey("select")) {
        if (mapSeniority["select"] != null) {
          String seniorityName = mapSeniority["select"]["name"] as String;
          String seniorityColor = mapSeniority["select"]["color"] as String;
          switch (seniorityName) {
            case StringConsts.notionSeniorityJunior:
              seniority = SeniorityModel(
                  seniority: Seniority.junior,
                  backgroundColorString: seniorityColor);
              break;
            case StringConsts.notionSeniorityMid:
              seniority = SeniorityModel(
                  seniority: Seniority.mid,
                  backgroundColorString: seniorityColor);
              break;
            case StringConsts.notionSenioritySenior:
              seniority = SeniorityModel(
                  seniority: Seniority.senior,
                  backgroundColorString: seniorityColor);
              break;
            default:
          }
        } //fine se la select di seniority non è null
      } //fine se seniorty ha la sua "select"
    } //fine parsing Seniority
    //*TITOLO ANNUNCIO
    //*(Name nelle properties)
    titolo = properties["Name"]["title"][0]["plain_text"] as String;
    //*Qualifica
    if (properties.containsKey("Qualifica")) {
      if ((properties["Qualifica"]["rich_text"] as List).isNotEmpty) {
        qualifica =
            properties["Qualifica"]["rich_text"][0]["plain_text"] as String;
      }
    } //fine parsing Qualifica
    //*RETRIBUZIONE
    if (properties.containsKey("Retribuzione")) {
      if ((properties["Retribuzione"]["rich_text"] as List).isNotEmpty) {
        retribuzione =
            properties["Retribuzione"]["rich_text"][0]["plain_text"] as String;
      }
    } //fine parsing retribuzione
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
          RichTextAnnotationModel annotations = RichTextAnnotationModel(
              bold: token["annotations"]["bold"] as bool,
              italic: token["annotations"]["italic"] as bool,
              strikethrough: token["annotations"]["strikethrough"] as bool,
              underline: token["annotations"]["underline"] as bool,
              code: token["annotations"]["code"] as bool,
              colorString: token["annotations"]["color"] as String?);
          descrizioneOfferta.add(RichTextModel(
            plainText: tokenPlainText,
            annotation: annotations,
          ));
        } //fine if se il rich text è di tipo text
      } //fine giro dei token dell'offerta
    } //fine parsing descrizione offerta come rich text
    //*COME CANDIDARSI
    String? urlComeCandiarsi;
    if (properties["Come candidarsi"]["rich_text"][0]["href"] != null) {
      urlComeCandiarsi =
          properties["Come candidarsi"]["rich_text"][0]["href"] as String;
    }
    comeCandidarsi = WebLinkModel(
      content:
          properties["Come candidarsi"]["rich_text"][0]["plain_text"] as String,
      url: urlComeCandiarsi,
    ); //fine parsing come candidarsi
    if (annuncioNotion['url'] != null) {
      urlAnnuncio = WebLinkModel(
          content: annuncioNotion['url'], url: annuncioNotion['url']);
    }
    //*LOCALITA
    if (properties.containsKey("Località")) {
      if ((properties["Località"]["rich_text"] as List).isNotEmpty) {
        localita =
            properties["Località"]["rich_text"][0]["plain_text"] as String?;
      }
    } //fine parsing località
    //*NOME AZIENDA!
    String? urlAzienda;
    if (properties["Nome azienda"]["rich_text"][0]["href"] != null) {
      urlAzienda = properties["Nome azienda"]["rich_text"][0]["href"] as String;
    }
    nomeAzienda = WebLinkModel(
        content:
            properties["Nome azienda"]["rich_text"][0]["plain_text"] as String,
        url: urlAzienda);
    return AnnuncioAziendaModel(
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
        urlAnnuncio: urlAnnuncio,
        tipoAnnuncio: tipoAnnuncio);
  } catch (e) {
    throw ParsingException();
  }
}

List<AnnuncioAziendaModel> parseNotionResponseListAziende(Response response) {
  List<AnnuncioAziendaModel> listaAnnunci = [];
  try {
    var emojiParser = EmojiParser();
    List annunciNotion = response.data["results"];

    return listaAnnunci;
  } catch (e) {
    throw ParsingException();
  }
}

List<AnnuncioAziendaModel> parseNotionResponseAziende(Response response) {
  List<AnnuncioAziendaModel> listaAnnunci = [];
  try {
    var emojiParser = EmojiParser();
    List annunciNotion = response.data["results"];
    for (Map<String, dynamic> annuncioNotion in annunciNotion) {
      // final String id = annuncioNotion['id'];
      // String? emoji;
      // TeamModel? team;
      // ContrattoModel? contratto;
      // SeniorityModel? seniority;
      // final String titolo;
      // String? qualifica;
      // String? retribuzione;
      // final List<RichTextModel> descrizioneOfferta = [];
      // WebLinkModel comeCandidarsi;
      // String? localita;
      // WebLinkModel nomeAzienda;
      // if (annuncioNotion.containsKey("icon")) {
      //   if (annuncioNotion["icon"]["type"] == "emoji") {
      //     try {
      //       emoji = emojiParser.getEmoji(annuncioNotion["icon"]["emoji"]).name;
      //     } on Exception {
      //       rethrow;
      //     }
      //   }
      // } //fine se c'era l'icona
      // //default false
      // final bool archived = annuncioNotion.containsKey("archived")
      //     ? annuncioNotion["archived"] as bool
      //     : false;
      // //*recupero le properties
      // Map<String, dynamic> properties = annuncioNotion["properties"];
      // //*data creazione annuncio
      // final DateTime jobPosted =
      //     DateTime.parse(properties["Job Posted"]["created_time"] as String);
      // //*TEAM
      // if (properties.containsKey("Team")) {
      //   Map<String, dynamic> mapTeam =
      //       properties["Team"] as Map<String, dynamic>;
      //   if (mapTeam.containsKey("select")) {
      //     if (mapTeam["select"] != null) {
      //       String teamName = mapTeam["select"]["name"] as String;
      //       String teamColor = mapTeam["select"]["color"] as String;

      //       if (AppConsts.notionTeams.contains(teamName)) {
      //         switch (teamName) {
      //           case StringConsts.notionTeamInSede:
      //             team = TeamModel(
      //                 team: Team.inSede, backgroundColorString: teamColor);
      //             break;
      //           case StringConsts.notionTeamIbrido:
      //             team = TeamModel(
      //                 team: Team.ibrido, backgroundColorString: teamColor);
      //             break;
      //           case StringConsts.notionTeamFullRemote:
      //             team = TeamModel(
      //                 team: Team.fullRemote, backgroundColorString: teamColor);
      //             break;
      //           default:
      //         }
      //       } //fine parsing del team
      //     } //fine se la select del team era non null
      //   } //fine se team aveva la sua "select"
      // } //fine parsing di Team
      // //*CONTRATTO
      // if (properties.containsKey("Contratto")) {
      //   Map<String, dynamic> mapContratto =
      //       properties["Contratto"] as Map<String, dynamic>;
      //   if (mapContratto.containsKey("select")) {
      //     if (mapContratto["select"] != null) {
      //       String contrattoName = mapContratto["select"]["name"] as String;
      //       String contrattoColor = mapContratto["select"]["color"] as String;

      //       switch (contrattoName) {
      //         case StringConsts.notionContrattoFullTime:
      //           contratto = ContrattoModel(
      //               contratto: Contratto.fullTime,
      //               backgroundColorString: contrattoColor);
      //           break;
      //         case StringConsts.notionContrattoPartTime:
      //           contratto = ContrattoModel(
      //               contratto: Contratto.partTime,
      //               backgroundColorString: contrattoColor);
      //           break;

      //         default:
      //       }
      //     } //fine se la select del contratto è non null
      //   } //fine se ho la select del contratto
      // } //fine parsing di Contratto
      // //*SENIORITY
      // if (properties.containsKey("Seniority")) {
      //   Map<String, dynamic> mapSeniority =
      //       properties["Seniority"] as Map<String, dynamic>;
      //   if (mapSeniority.containsKey("select")) {
      //     if (mapSeniority["select"] != null) {
      //       String seniorityName = mapSeniority["select"]["name"] as String;
      //       String seniorityColor = mapSeniority["select"]["color"] as String;
      //       switch (seniorityName) {
      //         case StringConsts.notionSeniorityJunior:
      //           seniority = SeniorityModel(
      //               seniority: Seniority.junior,
      //               backgroundColorString: seniorityColor);
      //           break;
      //         case StringConsts.notionSeniorityMid:
      //           seniority = SeniorityModel(
      //               seniority: Seniority.mid,
      //               backgroundColorString: seniorityColor);
      //           break;
      //         case StringConsts.notionSenioritySenior:
      //           seniority = SeniorityModel(
      //               seniority: Seniority.senior,
      //               backgroundColorString: seniorityColor);
      //           break;
      //         default:
      //       }
      //     } //fine se la select di seniority non è null
      //   } //fine se seniorty ha la sua "select"
      // } //fine parsing Seniority
      // //*TITOLO ANNUNCIO
      // //*(Name nelle properties)
      // titolo = properties["Name"]["title"][0]["plain_text"] as String;
      // //*Qualifica
      // if (properties.containsKey("Qualifica")) {
      //   if ((properties["Qualifica"]["rich_text"] as List).isNotEmpty) {
      //     qualifica =
      //         properties["Qualifica"]["rich_text"][0]["plain_text"] as String;
      //   }
      // } //fine parsing Qualifica
      // //*RETRIBUZIONE
      // if (properties.containsKey("Retribuzione")) {
      //   if ((properties["Retribuzione"]["rich_text"] as List).isNotEmpty) {
      //     retribuzione = properties["Retribuzione"]["rich_text"][0]
      //         ["plain_text"] as String;
      //   }
      // } //fine parsing retribuzione
      // //*DESCRIZIONE OFFERTA - RICHTEXT
      // if (properties.containsKey("Descrizione offerta")) {
      //   List<dynamic> richText = properties["Descrizione offerta"]["rich_text"];

      //   //Giro la lista dei "token" da cui è composta la descr dell'offerta
      //   for (var token in richText) {
      //     //la prendo come mappa perché nel json è così
      //     token = token as Map<String, dynamic>;
      //     //per ora prendo solo i rich text di tipo testo
      //     if (token['type'] == "text") {
      //       String tokenPlainText = token["plain_text"] as String;
      //       RichTextAnnotationModel annotations = RichTextAnnotationModel(
      //           bold: token["annotations"]["bold"] as bool,
      //           italic: token["annotations"]["italic"] as bool,
      //           strikethrough: token["annotations"]["strikethrough"] as bool,
      //           underline: token["annotations"]["underline"] as bool,
      //           code: token["annotations"]["code"] as bool,
      //           colorString: token["annotations"]["color"] as String?);
      //       descrizioneOfferta.add(RichTextModel(
      //         plainText: tokenPlainText,
      //         annotation: annotations,
      //       ));
      //     } //fine if se il rich text è di tipo text
      //   } //fine giro dei token dell'offerta
      // } //fine parsing descrizione offerta come rich text
      // //*COME CANDIDARSI
      // String? urlComeCandiarsi;
      // if (properties["Come candidarsi"]["rich_text"][0]["href"] != null) {
      //   urlComeCandiarsi =
      //       properties["Come candidarsi"]["rich_text"][0]["href"] as String;
      // }
      // comeCandidarsi = WebLinkModel(
      //   content: properties["Come candidarsi"]["rich_text"][0]["plain_text"]
      //       as String,
      //   url: urlComeCandiarsi,
      // ); //fine parsing come candidarsi
      // //*LOCALITA
      // if (properties.containsKey("Località")) {
      //   if ((properties["Località"]["rich_text"] as List).isNotEmpty) {
      //     localita =
      //         properties["Località"]["rich_text"][0]["plain_text"] as String?;
      //   }
      // } //fine parsing località
      // //*NOME AZIENDA!
      // String? urlAzienda;
      // if (properties["Nome azienda"]["rich_text"][0]["href"] != null) {
      //   urlAzienda =
      //       properties["Nome azienda"]["rich_text"][0]["href"] as String;
      // }
      // nomeAzienda = WebLinkModel(
      //     content: properties["Nome azienda"]["rich_text"][0]["plain_text"]
      //         as String,
      //     url: urlAzienda);
      var annuncioModel = parseNotionResponseSingoloAnnuncio(annuncioNotion);
      listaAnnunci.add(annuncioModel);
      // listaAnnunci.add(AnnuncioModel(
      //     id: id,
      //     titolo: titolo,
      //     nomeAzienda: nomeAzienda,
      //     descrizioneOfferta: descrizioneOfferta,
      //     comeCandidarsi: comeCandidarsi,
      //     jobPosted: jobPosted,
      //     archived: archived,
      //     contratto: contratto,
      //     emoji: emoji,
      //     localita: localita,
      //     qualifica: qualifica,
      //     retribuzione: retribuzione,
      //     seniority: seniority,
      //     team: team,
      //     tipoAnnuncio:
      //         TipoAnnuncio.aziende)); //aggiunto di annuncioModel alla lista
    } //fine giro sugli annunciNotion
    // listaAnnunci.sort(
    //   (b, a) =>
    //       a.jobPosted.compareTo(b.jobPosted), //discendente per Data annuncio
    // );
    return listaAnnunci;
  } catch (e) {
    throw ParsingException();
  }
}