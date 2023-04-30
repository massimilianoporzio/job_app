import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:job_app/features/aziende/data/mappers/annuncio_azienda_mapper.dart';
import 'package:job_app/features/aziende/data/models/annuncio_azienda_model.dart';

import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';
import 'package:job_app/features/freelancers/data/mappers/annuncio_freelancers_mapper.dart';
import 'package:job_app/features/freelancers/data/models/annuncio_freelancers_model.dart';
import 'package:job_app/features/freelancers/domain/entities/annuncio_freelancer.dart';

import '../../../../core/services/service_locator.dart';

class Preferito extends Equatable with Comparable {
  final AnnuncioAzienda? annuncioAzienda;
  final AnnuncioFreelancers? annuncioFreelancers;

  const Preferito({
    this.annuncioAzienda,
    this.annuncioFreelancers,
  }) : assert(
            (annuncioAzienda != null && annuncioFreelancers == null) ||
                (annuncioAzienda == null && annuncioFreelancers != null),
            "Non puoi usare due annunci o non usarne nessuno");

  DateTime get jobPosted {
    if (annuncioFreelancers == null) {
      return annuncioAzienda!.jobPosted;
    } else {
      return annuncioFreelancers!.jobPosted;
    }
  }

  @override
  List<Object?> get props => [annuncioAzienda, annuncioFreelancers];

  @override
  int compareTo(other) {
    return jobPosted.compareTo(other.jobPosted);
  }
  //SERIALIZZAZIONE è PER HYDRATED BLOC...la faccio qui per mancanza di tempo
  //come domain non dovrebbe avere nulla a che fare con la serializzazione...

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (annuncioAzienda != null) {
      result.addAll({
        'annuncioAzienda':
            sl<AnnuncioAziendaMapper>().fromEntity(annuncioAzienda!).toMap()
      });
    }
    if (annuncioFreelancers != null) {
      result.addAll({
        'annuncioFreelancers': sl<AnnuncioFreelancersMapper>()
            .fromEntity(annuncioFreelancers!)
            .toMap()
      });
    }

    return result;
  }

  factory Preferito.fromMap(Map<String, dynamic> json) {
    return Preferito(
      annuncioAzienda: json['annuncioAzienda'] != null
          ? sl<AnnuncioAziendaMapper>()
              .toEntity(AnnuncioAziendaModel.fromJson(json['annuncioAzienda']))
          : null,
      annuncioFreelancers: json['annuncioFreelancers'] != null
          ? sl<AnnuncioFreelancersMapper>().toEntity(
              AnnuncioFreelancersModel.fromJson(json['annuncioFreelancers']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Preferito.fromJson(String source) =>
      Preferito.fromMap(json.decode(source));
}
