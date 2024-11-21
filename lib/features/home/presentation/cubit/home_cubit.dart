import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/domain/usecases/get_gifs_use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetGifUseCase getGifUseCase;

  HomeCubit(this.getGifUseCase) : super(HomeInitial());

  getGifs() async {
    emit(HomeLoading());
    final result = await getGifUseCase.execute(
      searchQuery: 'gg',
      limit: 10,
    );
    result.fold(
      (failure) {
        emit(HomeFailed(failure.message));
      },
      (data) {
        emit(HomeSuccess(data));
      },
    );
  }

  init() {
    getGifs();
  }
}
