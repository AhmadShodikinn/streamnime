import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/preferences_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ShowcaseHeaderDetail(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ShowcaseHeaderDetail(),
            ShowcaseInformationDetail(),
            ShowcaseInformationEpisodes(),
            PreferencesPage(),
          ],
        ),
      ),

      // body: ListView(
      //   children: [
      //     ShowcaseHeaderDetail(),
      //     ShowcaseInformationDetail(),
      //     ShowcaseInformationEpisodes(),
      //   ],
      // ),
    );
  }

  // header images
  Widget ShowcaseHeaderDetail() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-header.jpg'), // atau .png
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 15,
            // child: Icon(Icons.arrow_back, color: Colors.white),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Positioned(
            top: 20,
            right: 15,
            child: Icon(Icons.cast_sharp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // information detail
  Widget ShowcaseInformationDetail() {
    return Container(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Demon Slayer (Kimetsu no Yaiba Mugen Ressha-hen)",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Baseline(
                        baseline: 24,
                        baselineType: TextBaseline.alphabetic,
                        child: Icon(FontAwesomeIcons.bookmark, size: 18),
                      ),
                      const SizedBox(width: 20),
                      Baseline(
                        baseline: 24,
                        baselineType: TextBaseline.alphabetic,
                        child: Icon(FontAwesomeIcons.paperPlane, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              spacing: 12,
              children: [
                Icon(
                  FontAwesomeIcons.solidStarHalfStroke,
                  size: 16,
                  color: AppColors.softGreen,
                ),
                Text(
                  "9.8",
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.softGreen,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Urbanist",
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.softGreen,
                ),
                Text(
                  "2022",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Urbanist",
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.softGreen, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    child: Text(
                      "13+",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.softGreen,
                        fontSize: 12,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.softGreen, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    child: Text(
                      "Japan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.softGreen,
                        fontSize: 12,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.softGreen, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    child: Text(
                      "Subtitle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.softGreen,
                        fontSize: 12,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Your button logic here
                      print('Button pressed!');
                    },
                    icon: const Icon(Icons.play_circle),
                    label: const Text('Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.softGreen,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      print("Button pressed!");
                    },
                    icon: const Icon(
                      Icons.system_update_alt,
                      color: AppColors.softGreen,
                    ),
                    label: const Text(
                      'Download',
                      style: TextStyle(color: AppColors.softGreen),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(width: 2, color: AppColors.softGreen),
                      // padding: const EdgeInsets.symmetric(
                      //   horizontal: 18,
                      //   vertical: 10,
                      // ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(right: 15),
              child: Text(
                "Genre: Action, Martial Arts, Adventure, Dark Fantasy, Thriller, Demon",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            ExpandableText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
              expandText: "View more",
              maxLines: 3,
              linkColor: AppColors.softGreen,
              animation: true,
              collapseOnTextTap: true,
            ),
          ],
        ),
      ),
    );
  }

  // information episodes
  Widget ShowcaseInformationEpisodes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Episodes",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Season 2",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.softGreen,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.softGreen,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ShowcaseEpisodeList(context),
      ],
    );
  }

  // Widget ShowcaseInformationEpisodes() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("Episodes"),
  //             Row(
  //               children: [Text("Season 2"), Icon(Icons.keyboard_arrow_down)],
  //             ),
  //             ShowcaseEpisodeList(context),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // showcase episode list
  Widget ShowcaseEpisodeList(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 15),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CardEpisodeShowcase(),
            );
          },
        ),
      ),
    );
  }

  // card episodes
  Widget CardEpisodeShowcase() {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/images/background-header.jpg'), // atau .png
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [Colors.grey.withOpacity(0.0), Colors.black],
          stops: [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.play_circle, color: Colors.white)),
          Positioned(
            bottom: 5,
            left: 5,
            child: Text(
              "Episode 1",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
