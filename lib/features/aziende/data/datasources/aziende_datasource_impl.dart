import 'package:dio/dio.dart';

import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';
import 'package:loggy/loggy.dart';

import '../../../../app/resources/string_constants.dart';

class AziendeDatasourceImpl implements AziendeDatasource {
  final Dio dio;
  AziendeDatasourceImpl({
    required this.dio,
  });

  @override
  Future<List<AnnuncioAzienda>> fetchAll() async {
    logDebug("DATASOURCE REMOTE");
    final response =
        await dio.post(StringConsts.baseUrlAziende, data: {"page_size": 2});
    print("in datasource");
    print(response.data);
    //TODO parser della risposta e lista
    return Future.value([]); //return lista vuota
  }

  @override
  Future<List<AnnuncioAzienda>> fetchPaginaSuccessiva() {
    // TODO: implement fetchPaginaSuccessiva
    throw UnimplementedError();
  }

  @override
  Future<List<AnnuncioAzienda>> fetchPrimaPagina() {
    // TODO: implement fetchPrimaPagina
    throw UnimplementedError();
  }
}
