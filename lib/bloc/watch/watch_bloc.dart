import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/watch/watch_event.dart';
import 'package:streaming_app/bloc/watch/watch_state.dart';
import 'package:streaming_app/data/repository/detail_anime_nonton_repository.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  final DetailAnimeNontonRepository detailAnimeNontonRepository;

  WatchBloc(this.detailAnimeNontonRepository) : super(WatchInitial()) {
    on<FetchDetailAnimeNonton>(_onFetchDetailAnimeNonton);
  }

  Future<void> _onFetchDetailAnimeNonton(
    FetchDetailAnimeNonton event,
    Emitter<WatchState> emit,
  ) async {
    emit(WatchLoading());

    try {
      final detailNontonData =
          await detailAnimeNontonRepository.FetchDetailAnimeNonton(
            event.episodeId,
          );

      emit(WatchLoaded(detailNontonData));
    } catch (e) {
      WatchError(e.toString());
    }
  }
}
