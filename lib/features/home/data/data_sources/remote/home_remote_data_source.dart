import 'package:cube_task/features/home/data/models/gif_response_data.dart';

import '../../../../../shared/data/network/api_endpoints.dart';
import '../../../../../shared/data/network/api_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote_data_source.g.dart';

@RestApi()
abstract class HomeRemoteDataSource {
  factory HomeRemoteDataSource(Dio dio, {String baseUrl}) =
      _HomeRemoteDataSource;

  @GET(ApiEndpoints.search)
  Future<ApiResponse<GifResponseData>> getGifs(
    @Query('q') String? searchKey,
    @Query('key') String apiKey,
    @Query('limit') int? limit,
    @Query('pos') int? position,
  );
}
