import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/watch/watch_event.dart';
import 'package:streaming_app/bloc/watch/watch_state.dart';
import 'package:streaming_app/data/models/detail_anime_nonton.dart';
import 'package:streaming_app/data/repository/detail_anime_nonton_repository.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  final DetailAnimeNontonRepository detailAnimeNontonRepository;

  WatchBloc(this.detailAnimeNontonRepository) : super(WatchInitial()) {
    on<FetchDetailAnimeNonton>(_onFetchDetailAnimeNonton);
    on<ChangeStreamingServer>(_onChangeStreamingServer);
  }

  Future<void> _onFetchDetailAnimeNonton(
    FetchDetailAnimeNonton event,
    Emitter<WatchState> emit,
  ) async {
    emit(WatchLoading());

    try {
      final detailData =
          await detailAnimeNontonRepository.FetchDetailAnimeNonton(
            event.episodeId,
          );

      emit(WatchLoaded(detailData));
    } catch (e) {
      emit(WatchError(e.toString()));
    }
  }

  Future<void> _onChangeStreamingServer(
    ChangeStreamingServer event,
    Emitter<WatchState> emit,
  ) async {
    final currentState = state;

    if (currentState is WatchLoaded) {
      // Emit loading khusus server change
      emit(WatchChangeServerLoading(currentState.detailAnimeNontonModel));

      try {
        // Panggil repository yang mengembalikan ChangeAnimeServerModel
        final changeServerData =
            await detailAnimeNontonRepository.ChangeServerNonton(
              event.serverId,
            );

        // Buat data baru berdasarkan data lama, tapi ganti defaultStreamingUrl
        final updatedData = DetailAnimeNontonData(
          title: currentState.detailAnimeNontonModel.data.title,
          animeId: currentState.detailAnimeNontonModel.data.animeId,
          releaseTime: currentState.detailAnimeNontonModel.data.releaseTime,
          defaultStreamingUrl: changeServerData.data.url, // ganti URL
          hasPrevEpisode:
              currentState.detailAnimeNontonModel.data.hasPrevEpisode,
          prevEpisode: currentState.detailAnimeNontonModel.data.prevEpisode,
          hasNextEpisode:
              currentState.detailAnimeNontonModel.data.hasNextEpisode,
          nextEpisode: currentState.detailAnimeNontonModel.data.nextEpisode,
          server: currentState.detailAnimeNontonModel.data.server,
          downloadUrl: currentState.detailAnimeNontonModel.data.downloadUrl,
          info: currentState.detailAnimeNontonModel.data.info,
        );

        // Emit state baru
        emit(
          WatchLoaded(
            DetailAnimeNontonModel(
              status: currentState.detailAnimeNontonModel.status,
              creator: currentState.detailAnimeNontonModel.creator,
              statusCode: currentState.detailAnimeNontonModel.statusCode,
              statusMessage: currentState.detailAnimeNontonModel.statusMessage,
              message: currentState.detailAnimeNontonModel.message,
              ok: currentState.detailAnimeNontonModel.ok,
              data: updatedData,
            ),
          ),
        );
      } catch (e) {
        emit(WatchError(e.toString()));
      }
    }
  }
}
