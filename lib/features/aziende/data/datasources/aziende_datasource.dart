import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';

abstract class AziendeDatasource {
  Future<List<AnnuncioAzienda>> fetchAll();
  Future<List<AnnuncioAzienda>> fetchPrimaPagina();
  Future<List<AnnuncioAzienda>> fetchPaginaSuccessiva();
}
