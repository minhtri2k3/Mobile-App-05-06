import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

// Model for error response
@JsonSerializable()
class ErrorResponse {
  final String message;
  final String error;
  final int statusCode;

  ErrorResponse({required this.message, required this.error, required this.statusCode});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}