import 'dart:async';
import 'dart:convert';

import 'package:cropi/src/services/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ApiClient {
  ApiClient({
    required domain,
  })  : _domain = domain,
        _baseUri = Uri.parse(domain) {
    if (!_domain.startsWith('http')) {
      throw Exception('Domain must start with http or https');
    }
  }

  final String _domain;
  final Uri _baseUri;
  String _authToken = '';

  String get fullUrl => _baseUri.toString();

  String get domain => _domain;

  void setAuthToken(String token) {
    _authToken = token;

    if (kDebugMode) {
      print(_authToken);
    }
  }

  Map<String, String> _headers() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (_authToken.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer $_authToken'});
    }

    return headers;
  }

  void logout() {
    _authToken = '';
  }

  Future<http.Response> get(
    url, {
    Map<String, String?>? query,
  }) async {
    final response = await http.get(
      _baseUri.replace(path: _baseUri.path + url, queryParameters: query),
      headers: _headers(),
    );

    if (response.statusCode > 400) {
      return Future.error(ApiClientException(response.body, response.statusCode,
          headers: response.headers));
    }

    if (kDebugMode) {
      print(response.body);
    }

    return response;
  }

  Future<http.Response> post(
    url, {
    Map<String, dynamic>? body,
    bool sendApiToken = false,
  }) async {
    try {
      final response = await http.post(
          _baseUri.replace(path: _baseUri.path + url),
          headers: _headers(),
          body: jsonEncode(body));
      if (response.statusCode > 400) {
        return Future.error(ApiClientException(
            response.body, response.statusCode,
            headers: response.headers));
      }

      if (kDebugMode) {
        print(response.body);
      }

      return response;
    } catch (e) {
      return Future.error(ApiClientException(e.toString(), 500));
    }
  }

  Future<http.Response> postFile(
    url, {
    required String path,
    required String fileName,
    required MediaType mediaType,
    bool sendApiToken = false,
  }) async {
    try {
      var file = await http.MultipartFile.fromPath(
        fileName,
        path,
        contentType: mediaType,
      );

      final response = http.MultipartRequest(
        "POST",
        _baseUri.replace(path: _baseUri.path + url),
      )
        ..headers.addAll(_headers())
        ..files.add(file);

      return await Response.fromStream(await response.send());
    } catch (e) {
      return Future.error(ApiClientException(e.toString(), 500));
    }
  }

  Map<String, dynamic> bodyToJson(http.Response response) {
    dynamic decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw ApiClientException(response.body, 500,
          error: e, headers: response.headers);
    }

    if (decoded is! Map<String, dynamic>) {
      return {
        "body": decoded,
      };
    }

    return decoded;
  }

  FutureOr<bool> check() async {
    try {
      final response = await get('health');
      final data = bodyToJson(response);
      return data['message'] == 'ok';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
