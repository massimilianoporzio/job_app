import 'package:job_app/features/aziende/domain/usecases/annunci_azienda_params.dart';

import '../../app/resources/string_constants.dart';

List buildFilterMapFromParamsAz(AnnunciAzParams params) {
  final listaFiltri = [];
  //FILTRI SU DESCRIZIONE OFFERTA OR TITOLO ANNUNCIO
  if (params.searchTerm.isNotEmpty) {
    Map<String, dynamic> searchTermMap = {"or": []};
    Map<String, dynamic> descrizioneOffertamMap = {
      "property": "Descrizione offerta",
      "rich_text": {"contains": params.searchTerm}
    };

    searchTermMap['or']
        .add(descrizioneOffertamMap); //FILTRA NELLA DESCRIZIONE OFFERTA
    Map<String, dynamic> titoloMap = {
      "property": "title",
      "rich_text": {"contains": params.searchTerm}
    };
    searchTermMap['or'].add(titoloMap);
    listaFiltri.add(searchTermMap);
  }
  //==== FINE FILTRI SU DESCR OFFERTA O TITOLO ANNUNCIO

  //==== FILTRI SU SENIORITY:
  if (!params.isSeniorityEmpty) {
    Map<String, dynamic> seniorityMap = {"or": []};
    if (params.juniorSeniorityFilter) {
      Map<String, dynamic> juniorMap = {
        "and": [
          {
            "property": StringConsts.notionSeniority,
            "select": {"equals": StringConsts.notionSeniorityJunior}
          },
          {
            "property": StringConsts.notionSeniority,
            "select": {"is_not_empty": true}
          }
        ],
      };
      seniorityMap['or'].add(juniorMap);
    }
    if (params.midSeniorityFilter) {
      Map<String, dynamic> midMap = {
        "and": [
          {
            "property": StringConsts.notionSeniority,
            "select": {"equals": StringConsts.notionSeniorityMid}
          },
          {
            "property": StringConsts.notionSeniority,
            "select": {"is_not_empty": true}
          }
        ],
      };
      seniorityMap['or'].add(midMap);
    }
    if (params.seniorSeniorityFilter) {
      Map<String, dynamic> seniorMap = {
        "and": [
          {
            "property": StringConsts.notionSeniority,
            "select": {"equals": StringConsts.notionSenioritySenior}
          },
          {
            "property": StringConsts.notionSeniority,
            "select": {"is_not_empty": true}
          }
        ],
      };
      seniorityMap['or'].add(seniorMap);
    }
    listaFiltri.add(seniorityMap);
  }

  //==== FINE FILTRI SU SENIORTY
  //==== FILTRI SU CONTRATTO:
  if (!params.isContrattoEmpty) {
    Map<String, dynamic> contrattoMap = {"or": []};
    if (params.partTimeFilter) {
      Map<String, dynamic> partTimeMap = {
        "and": [
          {
            "property": StringConsts.notionContratto,
            "select": {"equals": StringConsts.notionContrattoPartTime}
          },
          {
            "property": StringConsts.notionContratto,
            "select": {"is_not_empty": true}
          }
        ],
      };
      contrattoMap['or'].add(partTimeMap);
    }
    if (params.fullTimeFilter) {
      Map<String, dynamic> fullTimeMap = {
        "and": [
          {
            "property": StringConsts.notionContratto,
            "select": {"equals": StringConsts.notionContrattoFullTime}
          },
          {
            "property": StringConsts.notionContratto,
            "select": {"is_not_empty": true}
          }
        ],
      };
      contrattoMap['or'].add(fullTimeMap);
    }
    listaFiltri.add(contrattoMap);
  }

  //==== FINE FILTRI SU CONTRATTO

  //==== FILTRI SU TEAM:
  if (!params.isTeamEmpty) {
    Map<String, dynamic> teamMap = {"or": []};
    if (params.inSedeFilter) {
      Map<String, dynamic> inSedeMap = {
        "and": [
          {
            "property": StringConsts.notionTeam,
            "select": {"equals": StringConsts.notionTeamInSede}
          },
          {
            "property": StringConsts.notionTeam,
            "select": {"is_not_empty": true}
          }
        ],
      };
      teamMap['or'].add(inSedeMap);
    }
    if (params.ibridoFilter) {
      Map<String, dynamic> ibridoMap = {
        "and": [
          {
            "property": StringConsts.notionTeam,
            "select": {"equals": StringConsts.notionTeamIbrido}
          },
          {
            "property": StringConsts.notionTeam,
            "select": {"is_not_empty": true}
          }
        ],
      };
      teamMap['or'].add(ibridoMap);
    }
    if (params.fullRemoteFilter) {
      Map<String, dynamic> fullremoteMap = {
        "and": [
          {
            "property": StringConsts.notionTeam,
            "select": {"equals": StringConsts.notionTeamFullRemote}
          },
          {
            "property": StringConsts.notionTeam,
            "select": {"is_not_empty": true}
          }
        ],
      };
      teamMap['or'].add(fullremoteMap);
    }
    listaFiltri.add(teamMap);
  }

  //==== FINE FILTRI SU TEAM
  return listaFiltri;
}
