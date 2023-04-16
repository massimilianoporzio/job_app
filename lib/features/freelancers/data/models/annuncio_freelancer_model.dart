import '../../../../core/data/models/annuncio_model.dart';
import '../../../../core/domain/enums/tipologia_annunci.dart';

class AnnuncioFreelancerModel extends AnnuncioModel {
  final TipoAnnuncio tipologia = TipoAnnuncio.freelancers;
  const AnnuncioFreelancerModel(
      {required super.id,
      required super.titolo,
      super.qualifica,
      required super.nomeAzienda,
      super.team,
      super.contratto,
      super.seniority,
      super.retribuzione,
      required super.descrizioneOfferta,
      required super.comeCandidarsi,
      super.localita,
      super.emoji,
      required super.jobPosted,
      required super.archived});
}
