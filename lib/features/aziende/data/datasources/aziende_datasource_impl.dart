import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:job_app/core/log/datasource_logger.dart';
import 'package:job_app/features/aziende/data/datasources/aziende_datasource.dart';
import 'package:job_app/features/aziende/domain/entities/annuncio_azienda.dart';

import '../../../../app/resources/string_constants.dart';
import '../../../../core/domain/errors/exceptions.dart';

class AziendeDatasourceImpl with DatasourceLoggy implements AziendeDatasource {
  final Dio dio;
  SharedPreferences prefs;
  Connectivity connectivity;

  AziendeDatasourceImpl({
    required this.dio,
    required this.prefs,
    required this.connectivity,
  });

  @override
  Future<List<AnnuncioAzienda>> fetchAll() async {
    final connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException();
    }
    final response =
        await dio.post(StringConsts.baseUrlAziende, data: {"page_size": 2});
    loggy.debug("REPONSE FROM NORTION: $response");
    if (response.data != null) {
      loggy.debug(response.data["next_cursor"]);
    }
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
