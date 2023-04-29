import 'package:dartz/dartz.dart';
import 'package:job_app/features/aziende/domain/usecases/annunci_azienda_params.dart';
import 'package:job_app/features/freelancers/domain/entities/annuncio_freelancer.dart';
import 'package:job_app/features/freelancers/domain/usecases/annunci_freelancer_params.dart';

import '../../../../core/domain/entities/typedefs.dart';
import '../../../../core/domain/errors/failures.dart';

abstract class FreelancersRepository {
  Future<Either<Failure, AnnuncioFreelancerList>> loadAnnunciFreelancers(
      AnnunciFreelancersParams params);
  Future<Either<Failure, AnnuncioFreelancerList>> refreshAnnunciFreelancers(
      AnnunciFreelancersParams params);
  Future<Either<Failure, AnnuncioFreelancer>> fetchAnnuncioFreelancers(
      AnnunciFreelancersParams params);
}
