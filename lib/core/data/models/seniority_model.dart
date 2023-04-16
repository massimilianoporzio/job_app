import 'dart:convert';

import 'package:job_app/core/domain/entities/seniority_enitity.dart';

import '../../domain/enums/seniority.dart';

class SeniorityModel extends SeniorityEntity {
  const SeniorityModel(
      {required super.seniority, required backgroundColorString});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'seniority': seniority.toJson()});
    if (backgroundColorString != null) {
      result.addAll({'backgroundColorString': backgroundColorString});
    }

    return result;
  }

  factory SeniorityModel.fromJson(Map<String, dynamic> json) {
    return SeniorityModel(
      seniority: Seniority.fromJson(json['seniority']),
      backgroundColorString: json['backgroundColorString'],
    );
  }

  String toJson() => json.encode(toMap());
}
