import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data/models/home_anime_model.dart';
import 'package:streaming_app/presentation/constant/app_url.dart';

class HomeAnimeRepository {
  Future<HomeAnimeModel> fetchHomeAnimeData() async {
    final url = Uri.parse('${AppUrl.url}anime/home');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> json = jsonDecode(response.body);
        print('JSON keys: ${json.keys}');
        return HomeAnimeModel.fromJson(json);
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
