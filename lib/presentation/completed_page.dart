import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Completed Anime",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ShowcaseItemGrid(),
    );
  }

  Widget ShowcaseItemGrid() {
    // Data dummy untuk grid
    List<Map<String, String>> dummyData = List.generate(10, (index) {
      return {
        'rating': '8.${(index % 10) + 1}', // Rating dummy
        'episode': 'Episode ${index + 1}', // Episode dummy
        'image': 'assets/images/background-header.jpg', // Gambar dummy
      };
    });

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 kolom
        crossAxisSpacing: 6, // Spasi horizontal antar kolom
        mainAxisSpacing: 3, // Spasi vertical antar baris
        childAspectRatio: 0.75, // Sesuaikan rasio tinggi dan lebar item
      ),
      itemCount: dummyData.length, // Jumlah item grid
      itemBuilder: (context, index) {
        return ShowcaseItemList(
          rating: dummyData[index]['rating']!,
          episode: dummyData[index]['episode']!,
          image: dummyData[index]['image']!,
        );
      },
    );
  }

  Widget ShowcaseItemList({
    required String rating,
    required String episode,
    required String image,
  }) {
    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                rating,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
