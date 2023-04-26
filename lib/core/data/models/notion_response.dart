import '../../../features/aziende/data/models/annuncio_azienda_model.dart';

class NotionResponseDTO {
  bool hasMore;
  String? nextCursor;
  List<AnnuncioAziendaModel> listaAnnunci;

  factory NotionResponseDTO.empty() => NotionResponseDTO(
        hasMore: false,
        listaAnnunci: [],
      );

  NotionResponseDTO({
    this.hasMore = true,
    this.nextCursor,
    required this.listaAnnunci,
  });

  bool get isEmpty => listaAnnunci.isEmpty;
}
