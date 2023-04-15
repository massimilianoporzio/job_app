import 'package:equatable/equatable.dart';

import '../../../app/resources/enums/seniority.dart';
import '../../utils/mixins.dart';

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
}
