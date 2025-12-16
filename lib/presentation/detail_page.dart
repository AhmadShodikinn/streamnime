import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

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
            child: Icon(Icons.arrow_back, color: Colors.white),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Demon Slayer (Kimetsu ...",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist",
                  ),
                ),
                Row(children: [Icon(Icons.bookmark), Icon(Icons.send)]),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star),
                Text("9.8"),
                Icon(Icons.arrow_forward_ios),
                Text("2022"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.softGreen,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "13+",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.softGreen,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "Japan",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.softGreen,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "Subtitle",
                      style: TextStyle(
                        fontSize: 14,
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
                      // padding: const EdgeInsets.symmetric(
                      //   horizontal: 18,
                      //   vertical: 10,
                      // ),
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
            Text(
              "Genre: Action, Martial Arts, Adventure, Dark Fantasy, Thriller, ...",
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. View more..",
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
              Text("Episodes"),
              Row(
                children: [Text("Season 2"), Icon(Icons.keyboard_arrow_down)],
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
              padding: const EdgeInsets.only(right: 8),
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-header.jpg'), // atau .png
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.play_circle)),
          Positioned(bottom: 5, left: 5, child: Text("Episode 1")),
        ],
      ),
    );
  }
}
