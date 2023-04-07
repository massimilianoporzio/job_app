import 'dart:convert';
import 'dart:io';

// import 'package:easy_rich_text/easy_rich_text.dart';

void main() async {
  var input = await File('dummy_annunci.json').readAsString();
  var response = json.decode(input);
  List results = response['results'];
  var primoAnnuncio = results[0];
  var properties = primoAnnuncio['properties'];
  var descrizioneOfferta = properties['Descrizione offerta'];
  List<dynamic> richText = descrizioneOfferta["rich_text"];
  for (var token in richText) {
    if (token['type'] == "text") {
      String tokenString = token["text"]["content"];
      print(tokenString);
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
