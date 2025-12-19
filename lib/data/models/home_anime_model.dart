class HomeAnimeModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final HomeData data;
  final dynamic pagination;

  HomeAnimeModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory HomeAnimeModel.fromJson(Map<String, dynamic> json) {
    return HomeAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: HomeData.fromJson(json['data'] ?? {}),
      pagination: json['pagination'],
    );
  }
}

class HomeData {
  final HomeCategory ongoing;
  final HomeCategory completed;

  HomeData({required this.ongoing, required this.completed});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      ongoing: HomeCategory.fromJson(json['ongoing'] ?? {}),
      completed: HomeCategory.fromJson(json['completed'] ?? {}),
    );
  }
}

class HomeCategory {
  final String href;
  final String otakudesuUrl;
  final List<HomeAnimeItem> animeList;

  HomeCategory({
    required this.href,
    required this.otakudesuUrl,
    required this.animeList,
  });

  factory HomeCategory.fromJson(Map<String, dynamic> json) {
    return HomeCategory(
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
      animeList: (json['animeList'] as List? ?? [])
          .map((item) => HomeAnimeItem.fromJson(item))
          .toList(),
    );
  }
}

class HomeAnimeItem {
  final String title;
  final String poster;
  final int episodes;
  final String animeId;
  final String href;
  final String otakudesuUrl;

  // Ongoing
  final String? releaseDay;
  final String? latestReleaseDate;

  // Completed
  final String? score;
  final String? lastReleaseDate;

  HomeAnimeItem({
    required this.title,
    required this.poster,
    required this.episodes,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
    this.releaseDay,
    this.latestReleaseDate,
    this.score,
    this.lastReleaseDate,
  });

  factory HomeAnimeItem.fromJson(Map<String, dynamic> json) {
    return HomeAnimeItem(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      episodes: json['episodes'] ?? 0,
      animeId: json['animeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
      releaseDay: json['releaseDay'],
      latestReleaseDate: json['latestReleaseDate'],
      score: json['score'],
      lastReleaseDate: json['lastReleaseDate'],
    );
  }
}
