import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../utils/mixins.dart';
import '../enums/contratto.dart';

class ContrattoEntity extends Equatable with NotionColor {
  final Contratto contratto;
  final String? backgroundColorString;

  const ContrattoEntity({
    required this.contratto,
    this.backgroundColorString,
  });

  @override
  List<Object> get props => [contratto];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'contratto': contratto.toJson()});
    if (backgroundColorString != null) {
      result.addAll({'backgroundColorString': backgroundColorString});
    }

    return result;
  }

  factory ContrattoEntity.fromJson(Map<String, dynamic> json) {
    return ContrattoEntity(
      contratto: Contratto.fromJson(json['contratto']),
      backgroundColorString: json['backgroundColorString'],
    );
  }

  String toJson() => json.encode(toMap());
}
