abstract class WatchEvent {}

class FetchDetailAnimeNonton extends WatchEvent {
  final String episodeId;

  FetchDetailAnimeNonton(this.episodeId);
}
