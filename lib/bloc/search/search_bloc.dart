import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/search/search_event.dart';
import 'package:streaming_app/bloc/search/search_state.dart';
import 'package:streaming_app/data/repository/search_anime_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchAnimeRepository searchAnimeRepository;

  SearchBloc(this.searchAnimeRepository) : super(SearchInitial()) {
    on<FetchSearchAnimeData>(_onFetchSearchAnimeData);
  }

  Future<void> _onFetchSearchAnimeData(
    FetchSearchAnimeData event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final searchData = await searchAnimeRepository.fetchSearchAnimeData(
        event.query,
      );
      emit(SearchLoaded(searchData));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
