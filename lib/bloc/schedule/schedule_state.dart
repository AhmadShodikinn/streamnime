import 'package:streaming_app/data/models/schedule_anime_model.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final ScheduleAnimeModel scheduleData;

  ScheduleLoaded(this.scheduleData);
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
