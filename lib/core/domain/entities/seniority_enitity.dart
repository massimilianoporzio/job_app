import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../utils/mixins.dart';
import '../enums/seniority.dart';

class SeniorityEntity extends Equatable with NotionColor {
  final Seniority seniority;
  final String? backgroundColorString;

  const SeniorityEntity({
    required this.seniority,
    this.backgroundColorString,
  });

  @override
  List<Object> get props => [seniority];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'seniority': seniority.toJson()});
    if (backgroundColorString != null) {
      result.addAll({'backgroundColorString': backgroundColorString});
    }

    return result;
  }

  factory SeniorityEntity.fromJson(Map<String, dynamic> json) {
    return SeniorityEntity(
      seniority: Seniority.fromJson(json['seniority']),
      backgroundColorString: json['backgroundColorString'],
    );
  }

  String toJson() => json.encode(toMap());
}
