part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  final bool isRefresh;

  HomeLoading(this.isRefresh);
}

final class HomeSuccess extends HomeState {
  final List<GifResponse> gifs;
  final bool hasMore;

  HomeSuccess(this.gifs, this.hasMore);
}

final class HomeFailed extends HomeState {
  final String message;

  HomeFailed(this.message);
}
