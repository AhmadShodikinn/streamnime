// showcase_card.dart
import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/detail_page.dart';

class ShowcaseCard extends StatelessWidget {
  final String animeId;
  final String poster;
  final int lastEpisode;
  final String? rating;

  const ShowcaseCard({
    required this.animeId,
    required this.poster,
    required this.lastEpisode,
    this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      colors: [Colors.transparent, Colors.black87],
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (rating != null)
            Positioned(
              top: 15,
              left: 15,
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
              lastEpisode.toString(),
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Urbanist",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
