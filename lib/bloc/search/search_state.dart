import 'package:streaming_app/data/models/search_anime_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchAnimeModel searchData;

  SearchLoaded(this.searchData);
}

class SearchError extends SearchInitial {
  final String message;

  SearchError(this.message);
}
