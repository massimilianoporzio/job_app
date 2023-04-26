import 'package:job_app/core/data/models/notion_response.dart';

abstract class AziendeDatasource {
  Future<NotionResponseDTO> fetchAnnunci();
  Future<NotionResponseDTO> fetchPrimaPaginaAnnunci();
  Future<NotionResponseDTO> fetchProssimaPaginaAnnunci(String startCursor);
  Future<NotionResponseDTO> fetchAnnuncio(String annuncioId);
}
