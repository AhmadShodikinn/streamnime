import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data/models/ongoing_anime_model.dart';
import 'package:streaming_app/presentation/constant/app_url.dart';

class OngoingAnimeRepository {
  Future<OngoingAnimeModel> fetchOngoingAnimeData() async {
    final url = Uri.parse('${AppUrl.url}anime/ongoing-anime');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return OngoingAnimeModel.fromJson(json);
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
