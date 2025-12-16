// showcase_card.dart
import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ShowcaseCard extends StatelessWidget {
  final String rating;
  final String number;

  const ShowcaseCard({required this.rating, required this.number, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/background-header.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
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
        Positioned(
          bottom: 15,
          left: 15,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 42,
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
