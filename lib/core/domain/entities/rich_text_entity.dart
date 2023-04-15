import 'dart:convert';

import 'package:job_app/core/domain/entities/rich_text_annotation.dart';

class RichTextTextEntity {
  final String plainText;
  final RichTextAnnotation annotation;

  RichTextTextEntity({
    required this.plainText,
    required this.annotation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'plainText': plainText});
    result.addAll({'annotation': annotation.toMap()});

    return result;
  }

  factory RichTextTextEntity.fromJson(Map<String, dynamic> map) {
    return RichTextTextEntity(
      plainText: map['plainText'] ?? '',
      annotation: RichTextAnnotation.fromJson(map['annotation']),
    );
  }

  String toJson() => json.encode(toMap());
}
