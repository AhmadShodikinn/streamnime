class SearchAnimeModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final SearchData data;
  final dynamic pagination;

  SearchAnimeModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory SearchAnimeModel.fromJson(Map<String, dynamic> json) {
    return SearchAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: SearchData.fromJson(json['data'] ?? {}),
      pagination: json['pagination'],
    );
  }
}

class SearchData {
  final List<SearchAnimeItem> animeList;

  SearchData({required this.animeList});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      animeList: (json['animeList'] as List? ?? [])
          .map((item) => SearchAnimeItem.fromJson(item))
          .toList(),
    );
  }
}

class SearchAnimeItem {
  final String title;
  final String poster;
  final String status;
  final String score;
  final String animeId;
  final String href;
  final String otakudesuUrl;
  final List<SearchGenre> genreList;

  SearchAnimeItem({
    required this.title,
    required this.poster,
    required this.status,
    required this.score,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
    required this.genreList,
  });

  factory SearchAnimeItem.fromJson(Map<String, dynamic> json) {
    return SearchAnimeItem(
      title: json['title'] ?? '',
      poster: json['poster'] ?? '',
      status: json['status'] ?? '',
      score: json['score'] ?? '',
      animeId: json['animeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
      genreList: (json['genreList'] as List? ?? [])
          .map((item) => SearchGenre.fromJson(item))
          .toList(),
    );
  }
}

class SearchGenre {
  final String title;
  final String genreId;
  final String href;
  final String otakudesuUrl;

  SearchGenre({
    required this.title,
    required this.genreId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory SearchGenre.fromJson(Map<String, dynamic> json) {
    return SearchGenre(
      title: json['title'] ?? '',
      genreId: json['genreId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}
