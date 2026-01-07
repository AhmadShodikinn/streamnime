class ScheduleAnimeModel {
  final String status;
  final String creator;
  final List<ScheduleAnimeDay> data;

  ScheduleAnimeModel({
    required this.status,
    required this.creator,
    required this.data,
  });

  factory ScheduleAnimeModel.fromJson(Map<String, dynamic> json) {
    return ScheduleAnimeModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => ScheduleAnimeDay.fromJson(e))
          .toList(),
    );
  }
}

class ScheduleAnimeDay {
  final String day;
  final List<ScheduleAnimeItem> animeList;

  ScheduleAnimeDay({required this.day, required this.animeList});

  factory ScheduleAnimeDay.fromJson(Map<String, dynamic> json) {
    return ScheduleAnimeDay(
      day: json['day'] ?? '',
      animeList: (json['anime_list'] as List? ?? [])
          .map((e) => ScheduleAnimeItem.fromJson(e))
          .toList(),
    );
  }
}

class ScheduleAnimeItem {
  final String title;
  final String slug;
  final String url;
  final String poster;

  ScheduleAnimeItem({
    required this.title,
    required this.slug,
    required this.url,
    required this.poster,
  });

  factory ScheduleAnimeItem.fromJson(Map<String, dynamic> json) {
    return ScheduleAnimeItem(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      url: json['url'] ?? '',
      poster: json['poster'] ?? '',
    );
  }
}
