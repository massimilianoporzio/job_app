import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/resources/string_constants.dart';
import '../../../../core/data/models/annuncio_model.dart';
import '../../../../core/data/models/notion_response.dart';
import '../../../../core/domain/errors/exceptions.dart';
import '../../../../core/log/datasource_logger.dart';
import '../parsers/notion_aziende_parser.dart';
import 'aziende_datasource.dart';

class AziendeDatasourceImpl with DatasourceLoggy implements AziendeDatasource {
  final Dio dio;
  SharedPreferences prefs;

  AziendeDatasourceImpl({
    required this.dio,
    required this.prefs,
  });

  @override
  Future<NotionResponseDTO> fetchAll() async {
    bool? hasMore;
    String? nextCursor;
    List<AnnuncioModel> listaAnnunci = [];
    try {
      final Response response =
          await dio.post(StringConsts.baseUrlAziende, data: {"page_size": 2});
      loggy.debug("REPONSE FROM NOTION: $response");

      loggy.debug(response.data["next_cursor"]);
      loggy.debug(response.data[""]);
      if (response.data["next_cursor"] != null) {
        nextCursor = response.data["next_cursor"] as String;
      }
      if (response.data["has_more"] != null) {
        hasMore = response.data["has_more"] as bool;
      }
      listaAnnunci = parseNotionResponseAziende(response);

      // loggy.debug("ECCO LA LISTA DEGLI ANNUNCI MODEL:\n$listaAnnunci");
      return NotionResponseDTO(
        listaAnnunci: listaAnnunci,
        hasMore: hasMore,
        nextCursor: nextCursor,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        throw NetworkException();
      }
      rethrow;
    } on Exception {
      throw RestApiException();
    }
  }

  @override
  Future<NotionResponseDTO> fetchPaginaSuccessiva() {
    // TODO: implement fetchPaginaSuccessiva
    throw UnimplementedError();
  }

  @override
  Future<NotionResponseDTO> fetchPrimaPagina() {
    // TODO: implement fetchPrimaPagina
    throw UnimplementedError();
  }
}
