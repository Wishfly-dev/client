import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wishfly/src/io/api/failures.dart';
import 'package:wishfly_shared/wishfly_shared.dart';

class WishflyApiClient {
  /// Create an instance of [WishflyApiClient] that integrates
  /// with the remote API.
  WishflyApiClient({
    required String apiKey,
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'https://api.wishfly.dev',
          apiKey: apiKey,
          httpClient: httpClient,
        );

  /// Create an instance of [WishflyApiClient] that integrates
  /// with a local instance of the API (http://localhost:8080).
  WishflyApiClient.localhost({
    required String apiKey,
    http.Client? httpClient,
  }) : this._(
          baseUrl: 'http://localhost:8090',
          apiKey: apiKey,
          httpClient: httpClient,
        );

  WishflyApiClient._({
    required String baseUrl,
    required String apiKey,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _apiKey = apiKey,
        _httpClient = httpClient ?? http.Client();

  final String _baseUrl;
  final http.Client _httpClient;
  static const unknownErrorMessage = 'An unknown error occurred.';

  /// API key used for authentication with the API.
  String _apiKey;

  /// POST /api/v1/auth/register
  /// Creates a new user
  Future<LoginResponseDto> register(
      {required RegisterRequestDto request}) async {
    final uri = Uri.parse('$_baseUrl/api/v1/auth/register');
    final response = await _httpClient.post(
      uri,
      body: json.encode(request.toJson()),
    );
    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw _parseErrorResponse(response.body, response.statusCode);
    }

    return LoginResponseDto.fromJson(body);
  }

  /// GET /api/v1/project
  /// Returns list of projects.
  Future<List<ProjectResponseDto>> getProjects() async {
    final uri = Uri.parse('$_baseUrl/api/v1/project');
    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );

    final body = response.jsonList();

    if (response.statusCode != HttpStatus.ok) {
      throw _parseErrorResponse(response.body, response.statusCode);
    }

    return body.map((data) => ProjectResponseDto.fromJson(data)).toList();
  }

  /// GET /api/v1/project/<id>
  /// Requests project based in given id.
  Future<ProjectResponseDto> getProject({
    required int id,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/v1/project/$id');
    final response = await _httpClient.get(
      uri,
      headers: await _getRequestHeaders(),
    );

    final body = response.json();

    if (response.statusCode != HttpStatus.ok) {
      throw _parseErrorResponse(response.body, response.statusCode);
    }

    return ProjectResponseDto.fromJson(body);
  }

  Future<void> createWish({required WishRequestDto request}) async {
    final uri = Uri.parse('$_baseUrl/api/v1/wish');
    final response = await _httpClient.post(
      uri,
      body: json.encode(request.toJson()),
      headers: await _getRequestHeaders(),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw _parseErrorResponse(response.body, response.statusCode);
    }
  }

  /// POST /api/v1/wish/$id/vote
  /// Vote for selected wish
  Future<void> vote({required int wishId}) async {
    final uri = Uri.parse('$_baseUrl/api/v1/wish/$wishId/vote');
    final response = await _httpClient.post(
      uri,
      headers: await _getRequestHeaders(),
    );

    if (response.statusCode != HttpStatus.created) {
      throw _parseErrorResponse(response.body, response.statusCode);
    }
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      "x-api-key": _apiKey,
    };
  }

  void close() => _httpClient.close();

  WishflyException _parseErrorResponse(String response, int status) {
    final ErrorResponse error;

    try {
      final body = json.decode(response) as Map<String, dynamic>;
      error = ErrorResponse.fromMap(body);
    } catch (_) {
      throw WishflyException(unknownErrorMessage, status);
    }
    return WishflyException(error.message, status);
  }
}

extension on http.Response {
  Map<String, dynamic> json() {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (_, stackTrace) {
      throw Exception(stackTrace);
    }
  }

  List jsonList() {
    try {
      return jsonDecode(body) as List;
    } catch (_, stackTrace) {
      throw Exception(stackTrace);
    }
  }
}
