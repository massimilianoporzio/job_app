import 'package:job_app/core/domain/entities/rich_text_annotation.dart';

class RichTextTextEntity {
  final String plainText;
  final RichTextAnnotation annotation;

  RichTextTextEntity({
    required this.plainText,
    required this.annotation,
  });
}
