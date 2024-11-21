import 'package:cube_task/features/home/data/data_sources/cache/home_cache_data_source.dart';
import 'package:cube_task/features/home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:cube_task/features/home/domain/repositories/home_repository.dart';
import 'package:cube_task/features/home/domain/usecases/get_gifs_use_case.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    HomeRemoteDataSource,
    HomeRepository,
    GetGifUseCase,
    HomeCacheDataSource,
  ],
  customMocks: [
    MockSpec<Dio>(as: #MockDio),
  ],
)
main() {}
