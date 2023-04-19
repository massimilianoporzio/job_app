class StringConsts {
  static const String appbarTitle = "Offerte di lavoro Flutter!";
  static const String bottomNavAziende = "Assunzioni";
  static const String bottomNavBookmarked = "Preferiti";
  static const String bottomNavFreelancers = "Freelancers";

  static const String notionSeniorityJunior = "Junior";
  static const String notionSeniorityMid = "Mid";
  static const String notionSenioritySenior = "Senior";

  static const String seniorityJunior = "Junior";
  static const String seniorityMid = "Mid";
  static const String senioritySenior = "Senior";
  static const String seniorityDefault = "-";

  static const String notionTeamInSede = "In sede";
  static const String notionTeamIbrido = "Ibrido";
  static const String notionTeamFullRemote = "Full remote";

  static const String teamInSede = "In sede";
  static const String teamIbrido = "Ibrido";
  static const String teamFullRemote = "Full remote";
  static const String teamDefault = "-";

  static const String notionYellow = "yellow";
  static const String notionRed = "red";
  static const String notionGreen = "green";
  static const String notionBlue = "blue";
  static const String notionPurple = "purple";
  static const String notionGrey = "grey";

  static const String notionContrattoFullTime = "Full time";
  static const String notionContrattoPartTime = "Part time";

  static const String contrattoFullTime = "Full Time";
  static const String contrattoPartTime = "Part Time";
  static const String contrattoDefault = "-";

  //*DA ENVIRONMENT
  static const String authToken = String.fromEnvironment('NOTION_TOKEN');
  static const String baseUrlAziende =
      String.fromEnvironment('NOTION_DB_AZIENDE');
  static const String baseUrlFreelancers = 'https://example.com';

  static const String oops = "Uh oh!";
  static const String genericError = "OOPS! Qualcosa è andato storto";
  static const String connectivtyError =
      "Non sei connesso a Internet. Controlla la connessione";
  static const String serverError = "Errore nel recupero dati\n dal Server";
  static const String tryAgain = "Prova ancora";
  static const String reloadThePage = "Ricarica la pagina";

  static const String notFound = "Not          Found.";
  static const String not = "  Not";
  static const String found = "     Found.";
  static const String notHor = "      Not";
  static const String foundHor = "   Found.";
}
