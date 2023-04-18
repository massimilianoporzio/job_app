import 'package:job_app/core/data/models/annuncio_model.dart';

class NotionResponseDTO {
  bool? hasMore;
  String? nextCursor;
  List<AnnuncioModel> listaAnnunci;

  NotionResponseDTO({
    this.hasMore,
    this.nextCursor,
    required this.listaAnnunci,
  });

  bool get isEmpty => listaAnnunci.isEmpty;
}
