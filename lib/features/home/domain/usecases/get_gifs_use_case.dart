import 'package:cube_task/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../shared/data/failures/failure.dart';
import '../../data/models/gif_response.dart';

class GetGifUseCase {
  final HomeRepository homeRepository;

  GetGifUseCase(this.homeRepository);

  Future<Either<Failure, List<GifResponse>>> execute({
    required String searchQuery,
    int? limit,
    int? position
  }) async {
    return homeRepository.getGifs(
      searchQuery: searchQuery,
      limit: limit,
      position: position,
    );
  }
}
