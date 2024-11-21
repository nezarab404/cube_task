import 'dart:convert';
import 'dart:developer';

import '../../../generated/locale_keys.g.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'api_response.dart';
import 'response_status.dart';
import 'error_response.dart';

///Custom Interceptor class so that we can control the requests
/// before/After it is being sent and on error occurred
class AppInterceptor extends InterceptorsWrapper {
  //Constructor that take the storage instance so that:
  // we can access it when passing the new options to Super class
  AppInterceptor()
      : super(
          onRequest: (options, handler) async {
            //adding our own headers to the interceptor
            final Map<String, dynamic> headers =
                {}; //await APIHelper.sharedHeaders;

            final customOptions = options;
            // final accessToken = '_storageProvider.accessToken';

            customOptions.headers = headers;

            // log("Access Token: $accessToken");
            // if (accessToken != null) {
            //   customOptions.headers['Authorization'] = 'Bearer $accessToken';
            // }

            log('Alpha interceptor on request called '
                'with headers ${customOptions.headers}');

            log('Alpha interceptor with URL ${customOptions.uri}');

            final connectivityResult = await Connectivity().checkConnectivity();

            if (connectivityResult.contains(ConnectivityResult.none)) {
              log('Alpha interceptor : No Network Connection');
              return handler.resolve(
                Response(
                  requestOptions: customOptions,
                  data: _handleErrorResponse(null).withErrorMessage.toJson(),
                ),
              );
            } else {
              return handler.next(customOptions);
            }
          },
          onResponse: (response, handler) {
            log('Alpha interceptor response will continue with $response');
            if (response.data is String) {
              return handler.resolve(
                Response(
                  data: ApiResponse.completed(response.data)
                      .withErrorMessage
                      .toJson(),
                  requestOptions: response.requestOptions,
                ),
              );
            }
            return handler.next(response);
          },
          onError: (error, handler) {
            log('Alpha interceptor on error called ${error.response}');
            return handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                data: _handleErrorResponse(error.response,
                        path: error.requestOptions.path)
                    .withErrorMessage
                    .toJson(),
              ),
            );
          },
        );

  ///Helper function that will return the error response in a structured way
  static ApiResponse _handleErrorResponse(Response? response, {String? path}) {
    log('Handle error in alpha interceptor');
    if (response == null) {
      return ApiResponse.error(
        errorData: ErrorResponse(
          ResponseStatus.noConnection,
          LocaleKeys.no_connection.tr(),
          ResponseStatus.noConnection,
        ),
      );
    }
    log('response status is ${response.statusCode}');
    switch (response.statusCode) {
      case 400:
      case 404:
      case 429:
        final responseJson = json.decode(response.toString());
        final errorResponse = ErrorResponse.fromJson(responseJson);
        return ApiResponse.error(errorData: errorResponse);
      case 401:
        // final responseJson = json.decode(response.toString());
        ErrorResponse? errorResponse;

        errorResponse = ErrorResponse(
          ResponseStatus.unauthorized,
          'unauthorized',
          ResponseStatus.unauthorized,
        );

        log('Error Response ${errorResponse.message}');

        return ApiResponse.error(errorData: errorResponse);
      case 500:
      default:
        final errorResponse = ErrorResponse(
            ResponseStatus.unknownException, 'Unknown', response.statusCode!);
        return ApiResponse.error(errorData: errorResponse);
    }
  }
}
