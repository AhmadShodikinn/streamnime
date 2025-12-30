import 'package:flutter/material.dart';
import 'package:streaming_app/data/models/detail_anime_model.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/widget/showcase_item_grid.dart';

class PreferencesPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<RecommendedAnimeItem> recommendedAnimeList;
  PreferencesPage({super.key, required this.recommendedAnimeList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: AppColors.softGreen,
              labelStyle: TextStyle(
                fontSize: 16,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: Colors.grey,
              indicatorPadding: EdgeInsetsGeometry.all(0.0),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
              indicator: ShapeDecoration(
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.softGreen,
                    width: 4,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              tabs: [
                Tab(text: "More Like This"),
                Tab(text: "Comments"),
              ],
            ),
            SizedBox(
              height: 500,
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 15),
                    child: ShowcaseItemGrid(
                      recommendedAnimeList,
                      _scrollController,
                    ),
                  ),
                  const Center(child: Text("No comment")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
