import 'dart:convert';

class RichTextAnnotation {
  final bool bold;
  final bool italic;
  final bool strikethrough;
  final bool underline;
  final bool code;
  final String? colorString;

  RichTextAnnotation({
    required this.bold,
    required this.italic,
    required this.strikethrough,
    required this.underline,
    required this.code,
    this.colorString,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'bold': bold});
    result.addAll({'italic': italic});
    result.addAll({'strikethrough': strikethrough});
    result.addAll({'underline': underline});
    result.addAll({'code': code});
    if (colorString != null) {
      result.addAll({'colorString': colorString});
    }

    return result;
  }

  factory RichTextAnnotation.fromJson(Map<String, dynamic> map) {
    return RichTextAnnotation(
      bold: map['bold'] ?? false,
      italic: map['italic'] ?? false,
      strikethrough: map['strikethrough'] ?? false,
      underline: map['underline'] ?? false,
      code: map['code'] ?? false,
      colorString: map['colorString'],
    );
  }

  String toJson() => json.encode(toMap());
}
