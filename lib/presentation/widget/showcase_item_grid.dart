import 'package:flutter/material.dart';
import 'package:streaming_app/data/models/anime_item_model.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/detail_page.dart';

class ShowcaseItemGrid extends StatelessWidget {
  // final List<CompleteAnimeItem> animeList;
  final List<AnimeItem> animeList;
  final ScrollController controller;

  const ShowcaseItemGrid(this.animeList, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
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
          animeId: anime.animeId,
          rating: anime.score,
          episode: anime.episodes,
          poster: anime.poster,
          context: context,
        );
      },
    );
  }

  Widget ShowcaseItemList({
    required String animeId,
    required String? rating,
    required int? episode,
    required String poster,
    required context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(animeId: animeId)),
        );
      },
      child: Stack(
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

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: episode == null
                        ? null
                        : const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87],
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
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
      ),
    );
  }
}
