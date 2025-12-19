import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_event.dart';
import 'package:streaming_app/bloc/complete/complete_state.dart';
import 'package:streaming_app/data/repository/complete_anime_repository.dart';

class CompleteBloc extends Bloc<CompleteEvent, CompleteState> {
  final CompleteAnimeRepository completeAnimeRepository;

  CompleteBloc(this.completeAnimeRepository) : super(CompleteInitial()) {
    on<FetchCompleteAnimeData>(_onFetchCompleteAnimeData);
  }

  Future<void> _onFetchCompleteAnimeData(
    FetchCompleteAnimeData event,
    Emitter<CompleteState> emit,
  ) async {
    emit(CompleteLoading());

    try {
      final completeData = await completeAnimeRepository
          .fetchCompleteAnimeData();
      emit(CompleteLoaded(completeData));
    } catch (e) {
      emit(CompleteError(e.toString()));
    }
  }
}
