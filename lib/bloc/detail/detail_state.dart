import 'package:streaming_app/data/models/detail_anime_model.dart';

abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailAnimeModel detailAnimeModel;

  DetailLoaded(this.detailAnimeModel);
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);
}
