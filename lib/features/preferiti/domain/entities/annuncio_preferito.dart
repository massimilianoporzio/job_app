import '../../../../core/domain/entities/annuncio.dart';
import '../../../../core/domain/enums/tipologia_annunci.dart';

class AnnuncioPreferito extends Annuncio {
  final TipoAnnuncio tipologia;
  const AnnuncioPreferito(
      {required this.tipologia,
      required super.id,
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
