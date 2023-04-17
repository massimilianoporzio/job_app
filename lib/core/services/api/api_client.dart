import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:job_app/app/resources/string_constants.dart';
import 'package:job_app/core/log/api_client_logger.dart';

class DioClient with ApiClientLoggy {
  static Future<Dio> createDio({bool isMock = false}) async {
    final dio = Dio(BaseOptions());
    dio.options.headers["authorization"] = StringConsts.authToken;
    dio.options.headers["Notion-Version"] = "2022-06-28";
    if (isMock) {
      final dioAdapter = DioAdapter(dio: dio);

      final data = await rootBundle.load('assets/json/dummy_page1.json');

      dioAdapter.onPost(StringConsts.baseUrlAziende, (server) {
        final map = jsonDecode(
          utf8.decode(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          ),
        );
        return server.reply(
          200,
          map,
          // Reply would wait for one-sec before returning data.
          delay: const Duration(seconds: 1),
        );
      }, data: {});
    }

    return Future.value(dio);
  }
}
