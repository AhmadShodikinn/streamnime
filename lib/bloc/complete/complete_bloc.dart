import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_event.dart';
import 'package:streaming_app/bloc/complete/complete_state.dart';
import 'package:streaming_app/data/models/complete_anime_model.dart';
import 'package:streaming_app/data/repository/complete_anime_repository.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  final CompleteAnimeRepository completeAnimeRepository;

  bool _isFetching = false;

  CompleteBloc(this.completeAnimeRepository) : super(CompleteInitial()) {
    on<FetchCompleteAnimeData>(_onFetchCompleteAnimeData);
    on<FetchMoreCompleteAnimeData>(_onFetchMoreCompleteAnimeData);
  }

  Future<void> _onFetchCompleteAnimeData(
    FetchCompleteAnimeData event,
    Emitter<CompleteState> emit,
  ) async {
    emit(CompleteLoading());

    try {
      final completeData = await completeAnimeRepository.fetchCompleteAnimeData(
        event.page,
      );
      emit(CompleteLoaded(completeData));
    } catch (e) {
      emit(CompleteError(e.toString()));
    }
  }

  Future<void> _onFetchMoreCompleteAnimeData(
    FetchMoreCompleteAnimeData event,
    Emitter<CompleteState> emit,
  ) async {
    if (_isFetching) return;
    if (state is! CompleteLoaded) return;

    final currentState = state as CompleteLoaded;
    final pagination = currentState.completeData.pagination;

    if (pagination == null || !pagination.hasNextPage) return;

    _isFetching = true;

    try {
      final nextPage = pagination.nextPage!;
      final nextData = await completeAnimeRepository.fetchCompleteAnimeData(
        nextPage,
      );

      final combinedList = [
        ...currentState.completeData.data.animeList,
        ...nextData.data.animeList,
      ];

      final updatedModel = CompleteAnimeModel(
        status: nextData.status,
        creator: nextData.creator,
        statusCode: nextData.statusCode,
        statusMessage: nextData.statusMessage,
        message: nextData.message,
        ok: nextData.ok,
        data: CompleteAnimeData(animeList: combinedList),
        pagination: nextData.pagination,
      );

      emit(CompleteLoaded(updatedModel));
    } catch (e) {
      emit(CompleteError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
