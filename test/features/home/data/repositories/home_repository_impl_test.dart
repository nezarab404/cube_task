import 'package:cube_task/features/home/data/models/gif_data.dart';
import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/data/models/gif_response_data.dart';
import 'package:cube_task/features/home/data/models/media.dart';
import 'package:cube_task/features/home/data/repositories/home_repository_impl.dart';
import 'package:cube_task/shared/data/failures/failure.dart';
import 'package:cube_task/shared/data/network/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

main() {
  late MockHomeRemoteDataSource dataSource;
  late HomeRepositoryImpl homeRepositoryImpl;

  setUp(() {
    dataSource = MockHomeRemoteDataSource();
    homeRepositoryImpl = HomeRepositoryImpl(dataSource);
  });

  GifResponseData testModel = GifResponseData(
    [
      GifResponse(
        '1',
        'description',
        [
          Media(
            GifData(
              10,
              [100, 100],
              2,
              'http://url.gif',
              'http://url.png',
            ),
          ),
        ],
      ),
    ],
    '20',
  );

  const testKeyword = 'test';
  const apiKey = 'LIVDSRZULELA';

  group('Test the getGifs method in the HomeRepository', () {
    test(
      'return GifResponseData When Success',
      () async {
        //arrange
        when(dataSource.getGifs(testKeyword, apiKey, 1, 1)).thenAnswer(
          (_) async => ApiResponse<GifResponseData>.completed(testModel),
        );
        //act
        final result = await homeRepositoryImpl.getGifs(
          searchQuery: testKeyword,
          limit: 1,
          position: 1,
        );
        //assert
        expect(result, equals(Right(testModel.results)));
      },
    );

    const errorMessage = 'Error happened, try again';
    test(
      'return GifResponseData when an error happened',
      () async {
        //arrange
        when(dataSource.getGifs(testKeyword, apiKey, 1, 1)).thenAnswer(
          (_) async => ApiResponse<GifResponseData>.error(
            errorMessage: errorMessage,
          ),
        );
        //act
        final result = await homeRepositoryImpl.getGifs(
          searchQuery: testKeyword,
          limit: 1,
          position: 1,
        );
        //assert
        expect(
          result,
          isA<Left>().having(
            (left) => left.value,
            'server failure',
            isA<ServerFailure>().having(
              (failure) => failure.message,
              'check the message',
              errorMessage,
            ),
          ),
        );
      },
    );
  });
}
