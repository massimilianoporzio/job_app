import 'package:job_app/core/data/models/notion_response.dart';

abstract class AziendeDatasource {
  Future<NotionResponseDTO> fetchAll();
  Future<NotionResponseDTO> fetchPrimaPagina();
  Future<NotionResponseDTO> fetchPaginaSuccessiva();
}
