import 'package:flutter/material.dart';
import 'package:streaming_app/data/models/complete_anime_model.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ShowcaseItemGrid extends StatelessWidget {
  final List<CompleteAnimeItem> animeList;
  const ShowcaseItemGrid(this.animeList, {super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk grid
    // List<Map<String, String>> dummyData = List.generate(10, (index) {
    //   return {
    //     'rating': '8.${(index % 10) + 1}', // Rating dummy
    //     'episode': 'Episode ${index + 1}', // Episode dummy
    //     'image': 'assets/images/background-header.jpg', // Gambar dummy
    //   };
    // });

    return GridView.builder(
      // padding: const EdgeInsets.symmetric(horizontal: 15),
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
          // rating: dummyData[index]['rating']!,
          // episode: dummyData[index]['episode']!,
          // image: dummyData[index]['image']!,
          rating: anime.score,
          episode: anime.episodes.toString(),
          poster: anime.poster,
        );
      },
    );
  }

  Widget ShowcaseItemList({
    required String rating,
    required String episode,
    required String poster,
  }) {
    return Stack(
      children: [
        // Container(
        //   height: 240,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        //   ),
        // ),
        Stack(
          children: [
            // Gambar
            Container(
              height: 220,
              width: 150,
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
              rating!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 15,
          left: 15,
          child: Text(
            episode,
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
