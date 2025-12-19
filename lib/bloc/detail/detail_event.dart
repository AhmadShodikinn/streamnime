abstract class DetailEvent {}

class FetchDetailAnimeData extends DetailEvent {
  final String animeId;

  FetchDetailAnimeData(this.animeId);
}
