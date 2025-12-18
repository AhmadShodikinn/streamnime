import 'package:streaming_app/data/models/ongoing_anime_model.dart';

abstract class OngoingState {}

class OngoingInitial extends OngoingState {}

class OngoingLoading extends OngoingState {}

class OngoingLoaded extends OngoingState {
  final OngoingAnimeModel ongoingData;

  OngoingLoaded(this.ongoingData);
}

class OngoingError extends OngoingState {
  final String message;

  OngoingError(this.message);
}
