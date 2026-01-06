abstract class WatchEvent {}

class FetchDetailAnimeNonton extends WatchEvent {
  final String episodeId;

  FetchDetailAnimeNonton(this.episodeId);
}


class ChangeStreamingServer extends WatchEvent {
  final String serverId;

  ChangeStreamingServer(this.serverId);
}