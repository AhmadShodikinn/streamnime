import 'package:flutter/material.dart';
import 'package:streaming_app/data/models/detail_anime_model.dart';
import 'package:streaming_app/presentation/completed_page.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/widget/showcase_item_grid.dart';

// test
// class PreferencesPage extends StatefulWidget {
//   @override
//   _PreferencesPageState createState() => _PreferencesPageState();
// }

// class _PreferencesPageState extends State<PreferencesPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = new TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.0),
//             border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8)),
//           ),
//           child: TabBar(
//             controller: _controller,
//             tabs: [
//               Tab(text: "More Like This"),
//               Tab(text: "Comments"),
//             ],
//           ),
//         ),
//         Container(
//           height: MediaQuery.of(context).size.height / 2.3,
//           child: new TabBarView(
//             controller: _controller,
//             children: <Widget>[
//               ShowcaseItemGrid(),
//               const Center(child: Text("No comment")),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class PreferencesPage extends StatelessWidget {
  final List<RecommendedAnimeItem> recommendedAnimeList;
  const PreferencesPage({super.key, required this.recommendedAnimeList});

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
                    child: ShowcaseItemGrid(recommendedAnimeList),
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
