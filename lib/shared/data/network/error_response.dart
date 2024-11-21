import 'package:json_annotation/json_annotation.dart';

import 'response_status.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  int code;
  String message;
  int statusCode;

  ErrorResponse(this.code, this.message, this.statusCode);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  bool get isItSessionExpiry => code == ResponseStatus.sessionExpired;

  @override
  String toString() {
    return 'ErrorResponse{code: $code, message: $message, statusCode: $statusCode}';
  }
}
