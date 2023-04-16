import '../../../../core/domain/entities/annuncio.dart';

class AnnuncioAzienda extends Annuncio {
  const AnnuncioAzienda(
      {required super.id,
      required super.titolo,
      required super.nomeAzienda,
      required super.descrizioneOfferta,
      required super.comeCandidarsi,
      required super.jobPosted,
      required super.archived});
}
