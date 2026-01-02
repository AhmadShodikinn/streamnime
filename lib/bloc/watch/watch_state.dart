import 'package:streaming_app/data/models/detail_anime_nonton.dart';

abstract class WatchState {}

class WatchInitial extends WatchState {}

class WatchLoading extends WatchState {}

class WatchLoaded extends WatchState {
  final DetailAnimeNontonModel detailAnimeNontonModel;

  WatchLoaded(this.detailAnimeNontonModel);
}

class WatchError extends WatchState {
  final String message;

  WatchError(this.message);
}
