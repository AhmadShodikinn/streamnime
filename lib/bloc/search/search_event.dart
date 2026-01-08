abstract class SearchEvent {}

class FetchSearchAnimeData extends SearchEvent {
  final String query;

  FetchSearchAnimeData(this.query);
}
