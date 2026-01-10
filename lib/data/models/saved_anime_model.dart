import 'package:streaming_app/data/models/anime_item_model.dart';

class SavedAnimeModel implements AnimeItem {
  @override
  final String animeId;
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
  final String? href;
  @override
  final String? otakudesuUrl;

  SavedAnimeModel({
    required this.animeId,
    required this.title,
    required this.poster,
    this.episodes,
    this.score,
    this.lastReleaseDate,
    this.href,
    this.otakudesuUrl,
  });

  factory SavedAnimeModel.fromJson(Map<String, dynamic> json) {
    return SavedAnimeModel(
      animeId: json['animeId'],
      title: json['title'],
      poster: json['poster'],
      episodes: json['episodes'],
      score: json['score'],
      lastReleaseDate: json['lastReleaseDate'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animeId': animeId,
      'title': title,
      'poster': poster,
      'episodes': episodes,
      'score': score,
      'lastReleaseDate': lastReleaseDate,
      'href': href,
      'otakudesuUrl': otakudesuUrl,
    };
  }
}
