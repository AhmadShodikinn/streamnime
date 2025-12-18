import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_event.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_state.dart';
import 'package:streaming_app/data/repository/ongoing_anime_repository.dart';

class OngoingBloc extends Bloc<OngoingEvent, OngoingState> {
  final OngoingAnimeRepository ongoingAnimeRepository;

  OngoingBloc(this.ongoingAnimeRepository) : super(OngoingInitial()) {
    on<FetchOngoingAnimeData>(_onFetchOngoingAnimeData);
  }

  Future<void> _onFetchOngoingAnimeData(
    FetchOngoingAnimeData event,
    Emitter<OngoingState> emit,
  ) async {
    emit(OngoingLoading());

    try {
      final ongoingData = await ongoingAnimeRepository.fetchOngoingAnimeData();
      emit(OngoingLoaded(ongoingData));
    } catch (e) {
      emit(OngoingError(e.toString()));
    }
  }
}
