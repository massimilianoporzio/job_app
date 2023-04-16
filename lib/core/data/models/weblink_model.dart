import 'dart:convert';

import 'package:job_app/core/domain/entities/weblink.dart';

class WebLinkModel extends Weblink {
  WebLinkModel({required super.content, url});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'content': content});
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory WebLinkModel.fromJson(Map<String, dynamic> json) {
    return WebLinkModel(
      content: json['content'] ?? '',
      url: json['url'],
    );
  }

  String toJson() => json.encode(toMap());
}
