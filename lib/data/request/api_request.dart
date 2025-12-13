import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:streaming_app/presentation/constant/app_url.dart';

class ApiRequest {
  final http.Client client;

  static String url = AppUrl.url;

  ApiRequest({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> request({
    required String endpoint,
    String method = 'GET',
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse('$url$endpoint');
    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case 'GET':
        default:
          response = await client
              .get(uri, headers: headers)
              .timeout(const Duration(seconds: 10));
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return null;
        }
      } else {
        throw ApiException(response.statusCode, response.body);
      }
    } catch (e) {
      throw ApiException(-1, e.toString());
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() {
    return 'ApiException: HTTP $statusCode - $message';
  }
}
