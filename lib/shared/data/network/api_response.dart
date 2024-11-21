import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'error_response.dart';
import 'response_status.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  Status? _status;
  T? data;
  String? errorMessage;
  ErrorResponse? errorData;

  ApiResponse();

  Status? get status => _status;

  ApiResponse.completed(this.data) : _status = Status.completed;

  ApiResponse.error({this.errorMessage, this.data, this.errorData})
      : _status = Status.error;

  ///Calling this function will be from Retrofit auto generated files
  ///will handle the data after it's being processed by our custom interceptor
  factory ApiResponse.fromJson(json, Function(Map<String, dynamic>) fromJsonT) {
    try {
      if (json is Map<String, dynamic> &&
          json['status'] != null &&
          json['status'] == Status.error) {
        // print('the error is : $json');
        return ApiResponse.error(
          data: json['data'],
          errorData: json['errorData'],
          errorMessage: json['message'],
        );
      }
      return ApiResponse.completed(fromJsonT(json));
    } catch (error) {
      if (kDebugMode) {
        print('the catched error is : $error');
      }
      return ApiResponse.error(
        errorMessage: error.toString(),
      );
      // }
    }
  }

  ///helper function will be used to get the object as json
  Map<String, dynamic> toJson() {
    return {
      'message': errorMessage,
      'data': data,
      'status': status,
      'errorData': errorData
    };
  }

  @override
  String toString() {
    return 'Status : $_status, Message : $errorMessage, Data : $data, ErrorData : $errorData';
  }

  ///A getter to check whether the response has finished successfully or not
  bool get hasSucceeded => _status == Status.completed;

  ///A getter to check whether the response has failed or not
  bool get hasFailed => _status == Status.error;

  ///Returns the returned API response in success case, in failure case it will
  /// use [_handleErrorMessage] to parse the error and return the appropriate
  /// error message
  ApiResponse<T> get withErrorMessage {
    if (_status == Status.completed) {
      return this;
    } else {
      return _handleErrorMessage(errorData);
    }
  }

  ///Checks the error response code and returns the suitable localized error
  /// message key
  ApiResponse<T> _handleErrorMessage(ErrorResponse? errorResponse) {
    if (errorResponse == null) {
      return ApiResponse.error(errorMessage: 'connection_error');
    }
    switch (errorResponse.code) {
      case ResponseStatus.noConnection:
        return ApiResponse.error(
          errorMessage: errorResponse.message,
          errorData: errorResponse,
        );

      default:
        return ApiResponse.error(errorMessage: 'unknown error');
    }
  }
}

enum Status { completed, error, sessionExpired }
