import 'dart:convert';

class ApiClientException implements Exception {
  final String body;
  final int status;
  final Map<String, dynamic> headers;
  final dynamic error;

  ApiClientException(
    this.body,
    this.status, {
    this.headers = const {},
    this.error,
  });

  Map<String, dynamic> get json => jsonDecode(body);

  @override
  String toString() {
    return 'ApiClientException{status: $status, error: $error, headers: $headers, body: $body}';
  }
}
