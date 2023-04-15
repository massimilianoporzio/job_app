import 'package:equatable/equatable.dart';

import '../../../app/resources/enums/contratto.dart';
import '../../utils/mixins.dart';

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
}
