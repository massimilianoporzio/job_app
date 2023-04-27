import 'package:dio/dio.dart';
import 'package:job_app/core/domain/usecases/base_usecase.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/resources/string_constants.dart';
import '../parsers/notion_azienda_parser.dart';
import '../models/annuncio_azienda_model.dart';
import '../../../../core/data/models/notion_response.dart';
import '../../../../core/domain/errors/exceptions.dart';
import '../../../../core/log/datasource_logger.dart';

import 'aziende_datasource.dart';

class AziendeDatasourceImpl with DatasourceLoggy implements AziendeDatasource {
  final Dio dio;
  SharedPreferences prefs;

  AziendeDatasourceImpl({
    required this.dio,
    required this.prefs,
  });

  @override
  Future<NotionResponseDTO> fetchAnnunci() async {
    bool hasMore = true;
    String? nextCursor;
    List<AnnuncioAziendaModel> listaAnnunci = [];
    try {
      Map<String, dynamic> bodyRequest = {};

      final Response response =
          await dio.post(StringConsts.baseUrlAziende, data: bodyRequest);
      loggy.debug("REPONSE FROM NOTION: $response");

      loggy.debug(response.data["next_cursor"]);

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
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.unknown) {
        throw NetworkException();
      }
      rethrow;
    } on Exception {
      throw RestApiException();
    }
  }

  @override
  Future<NotionResponseDTO> fetchProssimaPaginaAnnunci(
      String startCursor, AnnunciAzParams params) async {
    List<AnnuncioAziendaModel> listaAnnunci = [];
    try {
      Map<String, dynamic> payload = {
        "page_size":
            2 //per provare la paginazione se no default è 100 per notion
      };

      payload["start_cursor"] = startCursor;

      final Response response =
          await dio.post(StringConsts.baseUrlAziende, data: payload);
      loggy.debug("REPONSE FROM NOTION: $response");

      loggy.debug(response.data["next_cursor"]);
      loggy.debug(response.data[""]);
      bool hasMore = true; //c'è sempre fino a prova contraria
      String? nextCursor;
      if (response.data["next_cursor"] != null) {
        nextCursor = response.data["next_cursor"] as String;
      } else {
        hasMore = false;
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
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.unknown) {
        throw NetworkException();
      }
      rethrow;
    } on Exception {
      throw RestApiException();
    }
  }

  @override
  Future<NotionResponseDTO> fetchPrimaPaginaAnnunci(
      AnnunciAzParams params) async {
    //TODO DEVO USARE I PARAMS
    //*searchTerm in OR con i FILTRI (a loro volta tutti in OR)
    bool hasMore = true;
    String? nextCursor;
    List<AnnuncioAziendaModel> listaAnnunci = [];
    try {
      Map<String, dynamic> payload = {
        "page_size":
            2 //per provare la paginazione se no default è 100 per notion
      };
      final Response response =
          await dio.post(StringConsts.baseUrlAziende, data: payload);
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
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.unknown) {
        throw NetworkException();
      } else if (e.type == DioErrorType.badResponse) {
        throw const ServerException();
      }
      rethrow;
    } on Exception {
      throw RestApiException();
    }
  }

  @override
  Future<NotionResponseDTO> fetchAnnuncio(String annuncioId) async {
    try {
      List<AnnuncioAziendaModel> listaAnnunci = [];
      final Response response =
          await dio.post(StringConsts.baseUrlPage + annuncioId, data: {});

      loggy.debug("REPONSE FROM NOTION: $response");
      listaAnnunci = parseNotionResponseAziende(response);

      if (listaAnnunci.length != 1) {
        throw Exception();
      }
      return NotionResponseDTO(listaAnnunci: listaAnnunci);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError ||
          e.type == DioErrorType.unknown) {
        throw NetworkException();
      }
      if (e.response!.statusCode == 404) {
        throw NoAnnuncioException();
      }
      rethrow;
    } on Exception {
      throw RestApiException();
    }
  }
}
