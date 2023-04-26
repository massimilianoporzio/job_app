import 'package:dartz/dartz.dart';
import 'package:job_app/core/domain/entities/rich_text_entity.dart';
import 'package:job_app/features/freelancers/domain/entities/annuncio_freelancer.dart';

import '../../../features/aziende/domain/entities/annuncio_azienda.dart';

typedef AnnuncioAziendaList = List<AnnuncioAzienda>;
typedef AnnuncioFreelancerList = List<AnnuncioFreelancer>;
typedef AnnuncioList = List<Either<AnnuncioAzienda, AnnuncioFreelancer>>;
typedef Annuncio = Either<AnnuncioAzienda, AnnuncioFreelancer>;

typedef RichTextList = List<RichTextTextEntity>;
