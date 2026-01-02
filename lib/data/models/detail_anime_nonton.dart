class DetailAnimeNontonModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final DetailAnimeNontonData data;

  DetailAnimeNontonModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
  });

  factory DetailAnimeNontonModel.fromJson(Map<String, dynamic> json) {
    return DetailAnimeNontonModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: DetailAnimeNontonData.fromJson(json['data'] ?? {}),
    );
  }
}

class DetailAnimeNontonData {
  final String title;
  final String animeId;
  final String releaseTime;
  final String defaultStreamingUrl;
  final bool hasPrevEpisode;
  final EpisodeNavItem? prevEpisode;
  final bool hasNextEpisode;
  final EpisodeNavItem? nextEpisode;
  final Server server;
  final DownloadUrl downloadUrl;
  final AnimeInfo info;

  DetailAnimeNontonData({
    required this.title,
    required this.animeId,
    required this.releaseTime,
    required this.defaultStreamingUrl,
    required this.hasPrevEpisode,
    required this.prevEpisode,
    required this.hasNextEpisode,
    required this.nextEpisode,
    required this.server,
    required this.downloadUrl,
    required this.info,
  });

  factory DetailAnimeNontonData.fromJson(Map<String, dynamic> json) {
    return DetailAnimeNontonData(
      title: json['title'] ?? '',
      animeId: json['animeId'] ?? '',
      releaseTime: json['releaseTime'] ?? '',
      defaultStreamingUrl: json['defaultStreamingUrl'] ?? '',
      hasPrevEpisode: json['hasPrevEpisode'] ?? false,
      prevEpisode: json['prevEpisode'] != null
          ? EpisodeNavItem.fromJson(json['prevEpisode'])
          : null,
      hasNextEpisode: json['hasNextEpisode'] ?? false,
      nextEpisode: json['nextEpisode'] != null
          ? EpisodeNavItem.fromJson(json['nextEpisode'])
          : null,
      server: Server.fromJson(json['server'] ?? {}),
      downloadUrl: DownloadUrl.fromJson(json['downloadUrl'] ?? {}),
      info: AnimeInfo.fromJson(json['info'] ?? {}),
    );
  }
}

class EpisodeNavItem {
  final String title;
  final String episodeId;
  final String href;
  final String otakudesuUrl;

  EpisodeNavItem({
    required this.title,
    required this.episodeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory EpisodeNavItem.fromJson(Map<String, dynamic> json) {
    return EpisodeNavItem(
      title: json['title'] ?? '',
      episodeId: json['episodeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}

class Server {
  final List<ServerQuality> qualities;

  Server({required this.qualities});

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      qualities: (json['qualities'] as List? ?? [])
          .map((e) => ServerQuality.fromJson(e))
          .toList(),
    );
  }
}

class ServerQuality {
  final String title;
  final List<ServerItem> serverList;

  ServerQuality({required this.title, required this.serverList});

  factory ServerQuality.fromJson(Map<String, dynamic> json) {
    return ServerQuality(
      title: json['title'] ?? '',
      serverList: (json['serverList'] as List? ?? [])
          .map((e) => ServerItem.fromJson(e))
          .toList(),
    );
  }
}

class ServerItem {
  final String title;
  final String serverId;
  final String href;

  ServerItem({required this.title, required this.serverId, required this.href});

  factory ServerItem.fromJson(Map<String, dynamic> json) {
    return ServerItem(
      title: json['title'] ?? '',
      serverId: json['serverId'] ?? '',
      href: json['href'] ?? '',
    );
  }
}

class DownloadUrl {
  final List<DownloadQuality> qualities;

  DownloadUrl({required this.qualities});

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      qualities: (json['qualities'] as List? ?? [])
          .map((e) => DownloadQuality.fromJson(e))
          .toList(),
    );
  }
}

class DownloadQuality {
  final String title;
  final String size;
  final List<DownloadItem> urls;

  DownloadQuality({
    required this.title,
    required this.size,
    required this.urls,
  });

  factory DownloadQuality.fromJson(Map<String, dynamic> json) {
    return DownloadQuality(
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      urls: (json['urls'] as List? ?? [])
          .map((e) => DownloadItem.fromJson(e))
          .toList(),
    );
  }
}

class DownloadItem {
  final String title;
  final String url;

  DownloadItem({required this.title, required this.url});

  factory DownloadItem.fromJson(Map<String, dynamic> json) {
    return DownloadItem(title: json['title'] ?? '', url: json['url'] ?? '');
  }
}

class AnimeInfo {
  final String credit;
  final String encoder;
  final String duration;
  final String type;
  final List<GenreItem> genreList;
  final List<EpisodeItem> episodeList;

  AnimeInfo({
    required this.credit,
    required this.encoder,
    required this.duration,
    required this.type,
    required this.genreList,
    required this.episodeList,
  });

  factory AnimeInfo.fromJson(Map<String, dynamic> json) {
    return AnimeInfo(
      credit: json['credit'] ?? '',
      encoder: json['encoder'] ?? '',
      duration: json['duration'] ?? '',
      type: json['type'] ?? '',
      genreList: (json['genreList'] as List? ?? [])
          .map((e) => GenreItem.fromJson(e))
          .toList(),
      episodeList: (json['episodeList'] as List? ?? [])
          .map((e) => EpisodeItem.fromJson(e))
          .toList(),
    );
  }
}

class GenreItem {
  final String title;
  final String genreId;
  final String href;
  final String otakudesuUrl;

  GenreItem({
    required this.title,
    required this.genreId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory GenreItem.fromJson(Map<String, dynamic> json) {
    return GenreItem(
      title: json['title'] ?? '',
      genreId: json['genreId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}

class EpisodeItem {
  final String title;
  final int? eps;
  final String date;
  final String episodeId;
  final String href;
  final String otakudesuUrl;

  EpisodeItem({
    required this.title,
    required this.eps,
    required this.date,
    required this.episodeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory EpisodeItem.fromJson(Map<String, dynamic> json) {
    return EpisodeItem(
      title: json['title'] ?? '',
      eps: json['eps'],
      date: json['date'] ?? '',
      episodeId: json['episodeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}
