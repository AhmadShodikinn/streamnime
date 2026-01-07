import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data/models/schedule_anime_model.dart';
import 'package:streaming_app/presentation/constant/app_url.dart';

class ScheduleAnimeRepository {
  Future<ScheduleAnimeModel> fetchScheduleAnimeData() async {
    final url = Uri.parse('${AppUrl.url}anime/schedule');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> json = jsonDecode(response.body);
        return ScheduleAnimeModel.fromJson(json);
      } else {
        throw Exception(
          'Gagal memuat data: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Load failed: $e');
    }
  }
}
