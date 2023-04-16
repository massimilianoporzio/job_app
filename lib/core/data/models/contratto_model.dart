import 'dart:convert';

import 'package:job_app/core/domain/entities/contratto_entity.dart';

import '../../domain/enums/contratto.dart';

class ContrattoModel extends ContrattoEntity {
  const ContrattoModel({
    required super.contratto,
    required backgroundColorString,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'contratto': contratto.toJson()});
    if (backgroundColorString != null) {
      result.addAll({'backgroundColorString': backgroundColorString});
    }

    return result;
  }

  factory ContrattoModel.fromJson(Map<String, dynamic> json) {
    return ContrattoModel(
      contratto: Contratto.fromJson(json['contratto']),
      backgroundColorString: json['backgroundColorString'],
    );
  }

  String toJson() => json.encode(toMap());
}
