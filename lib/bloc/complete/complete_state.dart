import 'package:streaming_app/data/models/complete_anime_model.dart';

abstract class CompleteState {}

class CompleteInitial extends CompleteState {}

class CompleteLoading extends CompleteState {}

class CompleteLoaded extends CompleteState {
  final CompleteAnimeModel completeData;

  CompleteLoaded(this.completeData);
}

class CompleteError extends CompleteState {
  final String message;

  CompleteError(this.message);
}
