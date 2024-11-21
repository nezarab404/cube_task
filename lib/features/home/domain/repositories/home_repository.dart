import 'package:dartz/dartz.dart';

import '../../../../shared/data/failures/failure.dart';
import '../../data/models/gif_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<GifResponse>>> getGifs({
    required String searchQuery,
    int? limit = 20,
    int? position = 0,
  });
}
