class OngoingAnimeModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final OngoingData data;
  final Pagination? pagination;

  OngoingAnimeModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory OngoingAnimeModel.fromJson(Map<String, dynamic> json) {
    return OngoingAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: OngoingData.fromJson(json['data'] ?? {}),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class OngoingData {
  final List<OngoingAnimeItem> animeList;

  OngoingData({required this.animeList});

  factory OngoingData.fromJson(Map<String, dynamic> json) {
    return OngoingData(
      animeList: (json['animeList'] as List? ?? [])
          .map((item) => OngoingAnimeItem.fromJson(item))
          .toList(),
    );
  }
}

class OngoingAnimeItem {
  final String title;
  final String poster;
  final int episodes;
  final String releaseDay;
  final String latestReleaseDate;
  final String animeId;
  final String href;
  final String otakudesuUrl;

  OngoingAnimeItem({
    required this.title,
    required this.poster,
    required this.episodes,
    required this.releaseDay,
    required this.latestReleaseDate,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory OngoingAnimeItem.fromJson(Map<String, dynamic> json) {
    return OngoingAnimeItem(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      episodes: json['episodes'] ?? 0,
      releaseDay: json['releaseDay'] ?? '',
      latestReleaseDate: json['latestReleaseDate'] ?? '',
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
      currentPage: json['currentPage'] ?? 1,
      hasPrevPage: json['hasPrevPage'] ?? false,
      prevPage: json['prevPage'],
      hasNextPage: json['hasNextPage'] ?? false,
      nextPage: json['nextPage'],
      totalPages: json['totalPages'] ?? 1,
    );
  }
}
