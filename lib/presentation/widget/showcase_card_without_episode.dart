// showcase_card.dart
import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ShowcaseCardWithoutEpisode extends StatelessWidget {
  final String poster;
  final int totalEpisode;
  final String? rating;

  const ShowcaseCardWithoutEpisode({
    required this.poster,
    required this.totalEpisode,
    this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          left: 10,
          child: Text(
            "$totalEpisode Episode",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Urbanist",
            ),
          ),
        ),
      ],
    );
  }
}
