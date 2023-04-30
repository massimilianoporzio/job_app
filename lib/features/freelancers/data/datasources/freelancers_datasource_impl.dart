import 'package:dio/dio.dart';

import 'package:job_app/core/log/datasource_logger.dart';
import 'package:job_app/features/freelancers/data/datasources/freelancers_datasource.dart';
import 'package:job_app/features/freelancers/data/parsers/notion_freelancer_parser.dart';
import 'package:job_app/features/freelancers/domain/usecases/annunci_freelancer_params.dart';

import '../../../../app/resources/string_constants.dart';
import '../../../../core/domain/errors/exceptions.dart';
import '../models/annuncio_freelancers_model.dart';
import '../models/notion_response_dto_freelancers.dart';

class FreelancersDataSourceImpl
    with DatasourceLoggy
    implements FreelancersDatasource {
  final Dio dio;
  FreelancersDataSourceImpl({
    required this.dio,
  });

  @override
  Future<NotionResponseFreelancersDTO> fetchAnnuncioFreelancers(
      String annuncioId) async {
    try {
      List<AnnuncioFreelancersModel> listaAnnunci = [];
      final Response response =
          await dio.post(StringConsts.baseUrlPage + annuncioId, data: {});

      loggy.debug("REPONSE FROM NOTION: $response");
      listaAnnunci = parseNotionResponseFreelancers(response);

      if (listaAnnunci.length != 1) {
        throw Exception();
      }
      return NotionResponseFreelancersDTO(listaAnnunci: listaAnnunci);
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

  @override
  Future<NotionResponseFreelancersDTO> fetchPrimaPaginaAnnunciFreelancers(
      AnnunciFreelancersParams params) {
    // TODO: implement fetchPrimaPaginaAnnunciFreelancers
    throw UnimplementedError();
  }

  @override
  Future<NotionResponseFreelancersDTO> fetchProssimaPaginaAnnunciFreelancers(
      String startCursor, AnnunciFreelancersParams params) {
    bool hasMore = true;
    String? nextCursor;
    List<AnnuncioFreelancersModel> listaAnnunci = [];
    try {
      Map<String, dynamic> payload = {
        "page_size":
            2, //per provare la paginazione se no default è 10 per notion
      };
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
    throw UnimplementedError();
  }
}
