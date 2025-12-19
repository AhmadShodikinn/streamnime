import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/detail/detail_event.dart';
import 'package:streaming_app/bloc/detail/detail_state.dart';
import 'package:streaming_app/data/repository/detail_anime_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailAnimeRepository detailAnimeRepository;

  DetailBloc(this.detailAnimeRepository) : super(DetailInitial()) {
    on<FetchDetailAnimeData>(_onFetchDetailAnimeData);
  }

  Future<void> _onFetchDetailAnimeData(
    FetchDetailAnimeData event,
    Emitter<DetailState> emit,
  ) async {
    emit(DetailLoading());

    try {
      final detailData = await detailAnimeRepository.fetchDetailAnimeData(
        event.animeId,
      );
      emit(DetailLoaded(detailData));
    } catch (e) {
      DetailError(e.toString());
    }
  }
}
