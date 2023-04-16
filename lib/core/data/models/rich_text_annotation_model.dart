import 'dart:convert';

import 'package:job_app/core/domain/entities/rich_text_annotation.dart';

class RichTextAnnotationModel extends RichTextAnnotation {
  RichTextAnnotationModel(
      {required super.bold,
      required super.italic,
      required super.strikethrough,
      required super.underline,
      required super.code,
      colorString});

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

  factory RichTextAnnotationModel.fromJson(Map<String, dynamic> map) {
    return RichTextAnnotationModel(
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
