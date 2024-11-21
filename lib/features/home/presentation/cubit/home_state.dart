part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<GifResponse> gifs;

  HomeSuccess(this.gifs);
}

final class HomeFailed extends HomeState {
  final String message;

  HomeFailed(this.message);
}
