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
import '../data_sources/remote/home_remote_data_source.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource services;

  HomeRepositoryImpl(this.services);

  @override
  Future<Either<Failure, List<GifResponse>>> getGifs({
    required String searchQuery,
    int? limit = 10,
    int? position = 0,
  }) async {
    final apiKey = dotenv.get(DotenvKeys.key);
    ApiResponse<GifResponseData> response = await services.getGifs(
      searchQuery,
      apiKey,
      limit,
      position,
    );
    if (response.hasSucceeded) {
      return Right(response.data!.results);
    } else {
      print("in repo : ${response.errorMessage}");
      if (response.errorData?.code == ResponseStatus.noConnection) {
        AppNotifications.showError(message: response.errorMessage ?? '');
        return const Right([]);
      }
      return Left(ServerFailure(response.errorMessage ?? ''));
    }
  }
}
