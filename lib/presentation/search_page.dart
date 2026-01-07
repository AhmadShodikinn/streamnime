import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/detail_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Map<String, String> dummyAnime = {
    "title":
        "Kimetsu no Yaiba: Hashira Geiko-hen (Episode 1 – 8) Subtitle Indonesia",
    "poster":
        "https://otakudesu.best/wp-content/uploads/2025/03/Kimetsu-no-Yaiba-Season-4-Sub-Indo.jpg",
    "slug": "kimetsu-yaiba-s4-sub-indo",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        // padding: EdgeInsetsGeometry.zero,
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
        child: Column(
          children: [
            Row(
              children: [
                /// 🔍 SEARCH
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppColors.softGreen,
                        size: 18,
                      ),

                      filled: true,
                      fillColor: AppColors.softGreen.withOpacity(0.15),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColors.softGreen,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColors.softGreen,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColors.softGreen,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// 🎛 FILTER BUTTON
                GestureDetector(
                  onTap: () {
                    // TODO: open filter bottom sheet
                  },
                  child: Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: AppColors.softGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(
                      //   color: AppColors.softGreen,
                      //   width: 1.5,
                      // ),
                    ),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.sliders,
                        color: AppColors.softGreen,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Align(
            //   alignment: AlignmentGeometry.centerLeft,
            //   child: Text("Top Searches"),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CardSearch(anime: dummyAnime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardSearch extends StatelessWidget {
  final Map<String, String> anime;

  const CardSearch({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      // padding: EdgeInsetsGeometry.zero,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => DetailPage(animeId: anime['slug']!),
              //   ),
              // );
            },
            child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://otakudesu.best/wp-content/uploads/2025/03/Kimetsu-no-Yaiba-Season-4-Sub-Indo.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(Icons.play_circle, color: Colors.white, size: 40),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              anime['title']!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
