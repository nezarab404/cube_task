import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/data/models/gif_response_data.dart';
import 'package:cube_task/features/home/domain/repositories/home_repository.dart';
import 'package:cube_task/shared/utils/dotenv_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../shared/data/failures/failure.dart';
import '../../../../shared/data/network/api_response.dart';
import '../../../../shared/utils/app_notifications.dart';

import '../../../../shared/data/network/response_status.dart';
import '../data_sources/cache/home_cache_data_source.dart';
import '../data_sources/remote/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource services;
  final HomeCacheDataSource cache;

  HomeRepositoryImpl(this.services, this.cache);

  @override
  Future<Either<Failure, List<GifResponse>>> getGifs({
    required String searchQuery,
    int? limit = 10,
    int? position = 0,
  }) async {
    ApiResponse<GifResponseData> response = await services.getGifs(
      searchQuery,
      'LIVDSRZULELA',
      limit,
      position,
    );
    if (response.hasSucceeded) {
      await cache.storeGifs(response.data!.results);
      return Right(response.data!.results);
    } else {
      if (response.errorData?.code == ResponseStatus.noConnection) {
        AppNotifications.showError(message: response.errorMessage ?? '');
        return Right(cache.getStoredGifs());
      }
      return Left(ServerFailure(response.errorMessage ?? ''));
    }
  }
}
