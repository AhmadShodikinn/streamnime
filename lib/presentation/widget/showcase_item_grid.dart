import 'package:flutter/material.dart';
import 'package:streaming_app/data/models/anime_item_model.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ShowcaseItemGrid extends StatelessWidget {
  // final List<CompleteAnimeItem> animeList;
  final List<AnimeItem> animeList;
  const ShowcaseItemGrid(this.animeList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 0.75,
      ),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        final anime = animeList[index];

        return ShowcaseItemList(
          rating: anime.score,
          episode: anime.episodes,
          poster: anime.poster,
        );
      },
    );
  }

  Widget ShowcaseItemList({
    required String? rating,
    required int? episode,
    required String poster,
  }) {
    return Stack(
      children: [
        Stack(
          children: [
            // Gambar
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(poster),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient gelap di bawah
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // atas tetap terang
                      Colors.black87, // bawah gelap
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        if (rating != null)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.softGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rating,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        if (episode != null)
          Positioned(
            bottom: 15,
            left: 15,
            child: Text(
              // episode.toString(),
              "$episode episode",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
