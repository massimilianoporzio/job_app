import 'package:job_app/core/data/models/annuncio_model.dart';

class NotionResponseDTO {
  bool hasMore;
  String? nextCursor;
  List<AnnuncioModel> listaAnnunci;

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
