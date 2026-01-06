class ChangeAnimeServerModel {
  final String status;
  final String creator;
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final ChangeAnimeServerData data;

  ChangeAnimeServerModel({
    required this.status,
    required this.creator,
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
  });

  factory ChangeAnimeServerModel.fromJson(Map<String, dynamic> json) {
    return ChangeAnimeServerModel(
      status: json['status'] ?? '',
      creator: json['creator'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      statusMessage: json['statusMessage'] ?? '',
      message: json['message'] ?? '',
      ok: json['ok'] ?? false,
      data: ChangeAnimeServerData.fromJson(json['data'] ?? {}),
    );
  }
}

class ChangeAnimeServerData {
  final String url;

  ChangeAnimeServerData({required this.url});

  factory ChangeAnimeServerData.fromJson(Map<String, dynamic> json) {
    return ChangeAnimeServerData(url: json['url'] ?? '');
  }
}
