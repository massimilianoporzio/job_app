import 'package:flutter/material.dart';
import 'package:job_app/features/aziende/presentation/pages/annunci_aziende.dart';
import 'package:job_app/features/freelancers/presentation/pages/annunci_freelancers.dart';
import 'package:job_app/features/preferiti/presentation/pages/annunci_preferiti.dart';

class PagesManager {
  static List<Widget> pages = [
    AnnunciAziende(),
    const AnnunciPreferiti(), //DUMMY
    AnnunciFreelancers(), // DUMMY
  ];
}
