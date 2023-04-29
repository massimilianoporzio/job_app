import 'package:job_app/core/data/models/notion_response.dart';

import 'package:job_app/features/aziende/domain/usecases/annunci_azienda_params.dart';

abstract class AziendeDatasource {
  Future<NotionResponseDTO> fetchAnnunci();
  Future<NotionResponseDTO> fetchPrimaPaginaAnnunci(AnnunciAzParams params);
  Future<NotionResponseDTO> fetchProssimaPaginaAnnunci(
      String startCursor, AnnunciAzParams params);
  Future<NotionResponseDTO> fetchAnnuncio(String annuncioId);
}
