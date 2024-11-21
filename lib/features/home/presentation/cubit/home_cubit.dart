import 'package:cube_task/features/home/data/models/gif_response.dart';
import 'package:cube_task/features/home/domain/usecases/get_gifs_use_case.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetGifUseCase getGifUseCase;

  HomeCubit(this.getGifUseCase) : super(HomeInitial());

  final searchController = TextEditingController();
  final scrollController = ScrollController();
  var itemsPerPage = 15;
  var _skip = 0;
  var _hasMore = true;
  List<GifResponse> gifs = [];

  getGifs({
    int? limit,
    int? position,
    bool isRefresh = false,
  }) async {
    /// if we are refreshing then we will sending a force request
    if (!isRefresh) {
      /// if we already sending a request
      if (state is HomeLoading) return;

      /// if we get all the data, then do not send any other request
      if (state is HomeSuccess && !(state as HomeSuccess).hasMore) return;
    }

    if (searchController.text.trim().isEmpty) {
      return;
    }
    emit(HomeLoading(isRefresh));

    if (isRefresh) {
      _skip = 0;
      _hasMore = true;
      gifs = [];
    }
    final result = await getGifUseCase.execute(
      searchQuery: searchController.text,
      limit: limit ?? itemsPerPage,
      position: position ?? _skip,
    );
    result.fold(
      (failure) {
        emit(HomeFailed(failure.message));
      },
      (data) {
        gifs.addAll(data);
        if (data.isEmpty) {
          _hasMore = false;
        }
        _skip += itemsPerPage;
        emit(HomeSuccess(gifs, _hasMore));
      },
    );
  }

  void _onScrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getGifs();
    }
  }

  init() {
    scrollController.addListener(_onScrollListener);
    getGifs();
  }
}
