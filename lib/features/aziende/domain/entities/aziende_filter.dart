import 'package:job_app/core/domain/entities/contratto_entity.dart';
import 'package:job_app/core/domain/entities/seniority_enitity.dart';
import 'package:job_app/core/domain/entities/team_entity.dart';

class AziendeFilter {
  TeamEntity? teamEntity;
  ContrattoEntity? contrattoEntity;
  SeniorityEntity? seniorityEntity;

  AziendeFilter({
    this.teamEntity,
    this.contrattoEntity,
    this.seniorityEntity,
  });
}
