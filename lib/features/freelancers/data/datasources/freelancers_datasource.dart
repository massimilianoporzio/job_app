import 'package:job_app/core/data/models/notion_response.dart';

import 'package:job_app/features/freelancers/domain/usecases/annunci_freelancer_params.dart';

abstract class FreelancersDatasource {
  Future<NotionResponseDTO> fetchPrimaPaginaAnnunciFreelancers(
      AnnunciFreelancersParams params);
  Future<NotionResponseDTO> fetchProssimaPaginaAnnunciFreelancers(
      String startCursor, AnnunciFreelancersParams params);
  Future<NotionResponseDTO> fetchAnnuncioFreelnacers(String annuncioId);
}
