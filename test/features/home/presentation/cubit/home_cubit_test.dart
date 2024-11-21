import 'package:cube_task/features/home/data/models/gif_data.dart';
import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/data/models/gif_response_data.dart';
import 'package:cube_task/features/home/data/models/media.dart';
import 'package:cube_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:cube_task/shared/data/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

main() {
  late MockGetGifUseCase getGifsUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    getGifsUseCase = MockGetGifUseCase();
    homeCubit = HomeCubit(getGifsUseCase);
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
  const errorMessage = 'An error happened';

  group(
    'Test the home cubit',
    () {
      test(
        'check the cubit initial state',
        () {
          expect(homeCubit.state, isA<HomeInitial>());
        },
      );

      blocTest<HomeCubit, HomeState>(
        'the states should be [HomeLoading,HomeSuccess] when the data retrieved successfully',
        //arrange
        build: () {
          when(
            getGifsUseCase.execute(
                searchQuery: testKeyword, limit: 10, position: 0),
          ).thenAnswer(
            (_) async => Right(testModel.results),
          );
          return homeCubit;
        },
        act: (cubit) {
          cubit.searchController.text = testKeyword;
          cubit.getGifs(limit: 10, position: 0);
        },
        expect: () => [
          isA<HomeLoading>(),
          isA<HomeSuccess>().having(
            (w) => w.gifs,
            'test the result data',
            equals(testModel.results),
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'the states should be [HomeLoading,HomeFailed] when an error happened',
        //arrange
        build: () {
          when(
            getGifsUseCase.execute(
                searchQuery: testKeyword, limit: 10, position: 0),
          ).thenAnswer(
            (_) async => Left(ServerFailure(errorMessage)),
          );
          return homeCubit;
        },
        act: (cubit) {
          cubit.searchController.text = testKeyword;
          cubit.getGifs(
            limit: 10,
            position: 0,
          );
        },
        expect: () => [
          isA<HomeLoading>(),
          isA<HomeFailed>().having(
            (w) => w.message,
            'test the error message',
            equals(errorMessage),
          ),
        ],
      );
    },
  );
}
