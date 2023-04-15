import 'dart:convert';

class Weblink {
  final String content;
  final String? url;
  Weblink({
    required this.content,
    this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'content': content});
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory Weblink.fromJson(Map<String, dynamic> json) {
    return Weblink(
      content: json['content'] ?? '',
      url: json['url'],
    );
  }

  String toJson() => json.encode(toMap());
}
