import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/schedule/schedule_event.dart';
import 'package:streaming_app/bloc/schedule/schedule_state.dart';
import 'package:streaming_app/data/repository/schedule_anime_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleAnimeRepository scheduleAnimeRepository;

  ScheduleBloc(this.scheduleAnimeRepository) : super(ScheduleInitial()) {
    on<FetchScheduleAnimeData>(_onFetchScheduleAnimeData);
  }

  Future<void> _onFetchScheduleAnimeData(
    FetchScheduleAnimeData event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());

    try {
      final scheduleData = await scheduleAnimeRepository
          .fetchScheduleAnimeData();
      emit(ScheduleLoaded(scheduleData));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}
