import 'package:streaming_app/data/models/home_anime_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeAnimeModel homeData;

  HomeLoaded(this.homeData);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
