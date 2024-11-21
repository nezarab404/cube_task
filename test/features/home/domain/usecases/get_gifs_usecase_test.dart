import 'package:cube_task/features/home/data/models/gif_data.dart';
import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/data/models/gif_response_data.dart';
import 'package:cube_task/features/home/data/models/media.dart';
import 'package:cube_task/features/home/domain/usecases/get_gifs_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

main() {
  late MockHomeRepository homeRepository;
  late GetGifUseCase getGifUseCase;

  setUp(() {
    homeRepository = MockHomeRepository();
    getGifUseCase = GetGifUseCase(homeRepository);
  });

  const testKeyword = 'test';

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

  test(
      'Ensures getGifUseCase returns the expected results from the repository for a valid query.',
      () async {
    //arrange
    when(
      homeRepository.getGifs(searchQuery: testKeyword, limit: 10, position: 0),
    ).thenAnswer(
      (_) async => Right(testModel.results),
    );
    //act
    final results = await getGifUseCase.execute(
        searchQuery: testKeyword, limit: 10, position: 0);

    //assert
    expect(results, equals(Right(testModel.results)));
  });
}
