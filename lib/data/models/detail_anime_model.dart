import 'package:streaming_app/data/models/anime_item_model.dart';

class DetailAnimeModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final DetailAnimeData data;

  DetailAnimeModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
  });

  factory DetailAnimeModel.fromJson(Map<String, dynamic> json) {
    return DetailAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: DetailAnimeData.fromJson(json['data'] ?? {}),
    );
  }
}

class DetailAnimeData {
  final String title;
  final String poster;
  final String japanese;
  final String score;
  final String producers;
  final String type;
  final String status;
  final int episodes;
  final String duration;
  final String aired;
  final String studios;
  final dynamic batch;
  final Synopsis synopsis;
  final List<GenreItem> genreList;
  final List<EpisodeItem> episodeList;
  final List<RecommendedAnimeItem> recommendedAnimeList;

  DetailAnimeData({
    required this.title,
    required this.poster,
    required this.japanese,
    required this.score,
    required this.producers,
    required this.type,
    required this.status,
    required this.episodes,
    required this.duration,
    required this.aired,
    required this.studios,
    required this.batch,
    required this.synopsis,
    required this.genreList,
    required this.episodeList,
    required this.recommendedAnimeList,
  });

  factory DetailAnimeData.fromJson(Map<String, dynamic> json) {
    return DetailAnimeData(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      japanese: json['japanese'] ?? '',
      score: json['score'] ?? '',
      producers: json['producers'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      episodes: json['episodes'] ?? 0,
      duration: json['duration'] ?? '',
      aired: json['aired'] ?? '',
      studios: json['studios'] ?? '',
      batch: json['batch'],
      synopsis: Synopsis.fromJson(json['synopsis'] ?? {}),
      genreList: (json['genreList'] as List? ?? [])
          .map((e) => GenreItem.fromJson(e))
          .toList(),
      episodeList: (json['episodeList'] as List? ?? [])
          .map((e) => EpisodeItem.fromJson(e))
          .toList(),
      recommendedAnimeList: (json['recommendedAnimeList'] as List? ?? [])
          .map((e) => RecommendedAnimeItem.fromJson(e))
          .toList(),
    );
  }
}

class Synopsis {
  final List<String> paragraphs;
  final List<dynamic> connections;

  Synopsis({required this.paragraphs, required this.connections});

  factory Synopsis.fromJson(Map<String, dynamic> json) {
    return Synopsis(
      paragraphs: List<String>.from(json['paragraphs'] ?? []),
      connections: json['connections'] ?? [],
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

class RecommendedAnimeItem implements AnimeItem {
  @override
  final String title;
  @override
  final String poster;
  @override
  final int? episodes;
  @override
  final String? score;
  @override
  final String? lastReleaseDate;
  @override
  final String animeId;
  @override
  final String href;
  @override
  final String otakudesuUrl;

  RecommendedAnimeItem({
    required this.title,
    required this.poster,
    this.episodes,
    this.score,
    this.lastReleaseDate,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory RecommendedAnimeItem.fromJson(Map<String, dynamic> json) {
    return RecommendedAnimeItem(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      episodes: null,
      score: null,
      lastReleaseDate: null,
      animeId: json['animeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}
