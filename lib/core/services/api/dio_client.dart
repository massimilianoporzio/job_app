import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:job_app/app/resources/string_constants.dart';

class DioClient {
  static Future<Dio> createDio() async {
    final dio = Dio(BaseOptions());
    dio.options.headers["authorization"] = StringConsts.authToken;
    dio.options.headers["Notion-Version"] = "2022-06-28";
    final dioAdapter = DioAdapter(dio: dio);

    final data = await File('dummy_annunci.json').readAsString();
    dioAdapter.onPost(StringConsts.baseUrlAziende, (server) {
      final map = jsonDecode(data);
      return server.reply(
        200,
        map,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      );
    }, data: {});
    // dio.interceptors.addAll([MockInterceptor()]);
    return Future.value(dio);
  }
}
