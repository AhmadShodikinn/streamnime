import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_event.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_state.dart';
import 'package:streaming_app/data/models/ongoing_anime_model.dart';
import 'package:streaming_app/data/repository/ongoing_anime_repository.dart';

class OngoingBloc extends Bloc<OngoingEvent, OngoingState> {
  final OngoingAnimeRepository ongoingAnimeRepository;

  bool _isFetching = false;

  OngoingBloc(this.ongoingAnimeRepository) : super(OngoingInitial()) {
    on<FetchOngoingAnimeData>(_onFetchOngoingAnimeData);
    on<FetchMoreOngoingAnimeData>(_onFetchMoreOngoingAnimeData);
  }

  Future<void> _onFetchOngoingAnimeData(
    FetchOngoingAnimeData event,
    Emitter<OngoingState> emit,
  ) async {
    emit(OngoingLoading());

    try {
      final ongoingData = await ongoingAnimeRepository.fetchOngoingAnimeData(
        event.page,
      );
      emit(OngoingLoaded(ongoingData));
    } catch (e) {
      emit(OngoingError(e.toString()));
    }
  }

  Future<void> _onFetchMoreOngoingAnimeData(
    FetchMoreOngoingAnimeData event,
    Emitter<OngoingState> emit,
  ) async {
    if (_isFetching) return;
    if (state is! OngoingLoaded) return;

    final currentState = state as OngoingLoaded;
    final pagination = currentState.ongoingData.pagination;

    if (pagination == null || !pagination.hasNextPage) return;

    _isFetching = true;

    try {
      final nextPage = pagination.nextPage!;
      final nextData = await ongoingAnimeRepository.fetchOngoingAnimeData(
        nextPage,
      );

      final combinedList = [
        ...currentState.ongoingData.data.animeList,
        ...nextData.data.animeList,
      ];

      final updatedModel = OngoingAnimeModel(
        status: nextData.status,
        creator: nextData.creator,
        statusCode: nextData.statusCode,
        statusMessage: nextData.statusMessage,
        message: nextData.message,
        ok: nextData.ok,
        data: OngoingData(animeList: combinedList),
        pagination: nextData.pagination,
      );

      emit(OngoingLoaded(updatedModel));
    } catch (e) {
      emit(OngoingError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
