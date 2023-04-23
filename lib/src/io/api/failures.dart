import 'dart:convert';

class WishflyApiMalformedResponse implements Exception {
  const WishflyApiMalformedResponse({required this.error});
  final Object error;
}

class WishfylApiRequestFailure implements Exception {
  const WishfylApiRequestFailure({
    required this.body,
    required this.statusCode,
  });

  final int statusCode;
  final Map<String, dynamic> body;
}

class ErrorResponse {
  const ErrorResponse({
    required this.code,
    required this.message,
    this.details,
  });

  /// The unique error code.
  final String code;

  /// Human-readable error message.
  final String message;

  /// Optional details associated with the error.
  final String? details;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'details': details,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      code: map['code'] ?? '',
      message: map['message'] ?? '',
      details: map['details'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source));
}
