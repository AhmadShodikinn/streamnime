import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streaming_app/data/models/detail_anime_nonton.dart';
import 'package:streaming_app/presentation/constant/app_url.dart';

class DetailAnimeNontonRepository {
  Future<DetailAnimeNontonModel> FetchDetailAnimeNonton(String epsId) async {
    final url = Uri.parse('${AppUrl.url}anime/episode/$epsId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return DetailAnimeNontonModel.fromJson(json);
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
