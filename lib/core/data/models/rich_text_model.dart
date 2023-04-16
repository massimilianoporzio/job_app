import 'dart:convert';

import '../../domain/entities/rich_text_entity.dart';
import 'rich_text_annotation_model.dart';

class RichTextModel extends RichTextTextEntity {
  const RichTextModel({
    required super.plainText,
    required super.annotation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'plainText': plainText});
    result.addAll(
        {'annotation': (annotation as RichTextAnnotationModel).toMap()});

    return result;
  }

  factory RichTextModel.fromJson(Map<String, dynamic> map) {
    return RichTextModel(
      plainText: map['plainText'] ?? '',
      annotation: RichTextAnnotationModel.fromJson(map['annotation']),
    );
  }

  String toJson() => json.encode(toMap());
}
