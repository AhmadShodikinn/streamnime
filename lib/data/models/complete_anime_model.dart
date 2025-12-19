class CompleteAnimeModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final CompleteAnimeData data;
  final Pagination? pagination;

  CompleteAnimeModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory CompleteAnimeModel.fromJson(Map<String, dynamic> json) {
    return CompleteAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: CompleteAnimeData.fromJson(json['data'] ?? {}),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class CompleteAnimeData {
  final List<CompleteAnimeItem> animeList;

  CompleteAnimeData({required this.animeList});

  factory CompleteAnimeData.fromJson(Map<String, dynamic> json) {
    return CompleteAnimeData(
      animeList: (json['animeList'] as List? ?? [])
          .map((e) => CompleteAnimeItem.fromJson(e))
          .toList(),
    );
  }
}

class CompleteAnimeItem {
  final String title;
  final String poster;
  final int episodes;
  final String score;
  final String lastReleaseDate;
  final String animeId;
  final String href;
  final String otakudesuUrl;

  CompleteAnimeItem({
    required this.title,
    required this.poster,
    required this.episodes,
    required this.score,
    required this.lastReleaseDate,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory CompleteAnimeItem.fromJson(Map<String, dynamic> json) {
    return CompleteAnimeItem(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      episodes: json['episodes'] ?? 0,
      score: json['score'] ?? '',
      lastReleaseDate: json['lastReleaseDate'] ?? '',
      animeId: json['animeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}

class Pagination {
  final int currentPage;
  final bool hasPrevPage;
  final int? prevPage;
  final bool hasNextPage;
  final int? nextPage;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.hasPrevPage,
    this.prevPage,
    required this.hasNextPage,
    this.nextPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 0,
      hasPrevPage: json['hasPrevPage'] ?? false,
      prevPage: json['prevPage'],
      hasNextPage: json['hasNextPage'] ?? false,
      nextPage: json['nextPage'],
      totalPages: json['totalPages'] ?? 0,
    );
  }
}
