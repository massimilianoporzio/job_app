import 'package:dio/dio.dart';
import 'package:job_app/core/data/models/notion_response.dart';

import 'package:job_app/core/log/datasource_logger.dart';
import 'package:job_app/features/freelancers/data/datasources/freelancers_datasource.dart';
import 'package:job_app/features/freelancers/domain/usecases/annunci_freelancer_params.dart';

class FreelancersDataSourceImpl
    with DatasourceLoggy
    implements FreelancersDatasource {
  final Dio dio;
  FreelancersDataSourceImpl({
    required this.dio,
  });

  @override
  Future<NotionResponseDTO> fetchAnnuncioFreelancers(String annuncioId) {
    // TODO: implement fetchAnnuncioFreelancers
    throw UnimplementedError();
  }

  @override
  Future<NotionResponseDTO> fetchPrimaPaginaAnnunciFreelancers(
      AnnunciFreelancersParams params) {
    // TODO: implement fetchPrimaPaginaAnnunciFreelancers
    throw UnimplementedError();
  }

  @override
  Future<NotionResponseDTO> fetchProssimaPaginaAnnunciFreelancers(
      String startCursor, AnnunciFreelancersParams params) {
    // TODO: implement fetchProssimaPaginaAnnunciFreelancers
    throw UnimplementedError();
  }
}
