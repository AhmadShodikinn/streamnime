import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/home/home_bloc.dart';
import 'package:streaming_app/bloc/home/home_event.dart';
import 'package:streaming_app/bloc/home/home_state.dart';
import 'package:streaming_app/data/repository/home_anime_repository.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            MainHeader(),
            ContentSection("Top Hits Anime"),
            showcaseCardList(context),
            ContentSection("New Episode Release"),
            showcaseCardList(context),
            SizedBox(height: 15),
          ],
        ),
      ),

      // home: BlocProvider(
      //   create: (_) => HomeBloc(HomeAnimeRepository())..add(FetchHomeData()),
      //   child: Scaffold(
      //     backgroundColor: Colors.white,
      //     body: BlocBuilder<HomeBloc, HomeState>(
      //       builder: (context, state) {
      //         if (state is HomeLoading) {
      //           return const Center(child: CircularProgressIndicator());
      //         } else if (state is HomeLoaded) {
      //           final ongoingList = state.homeData.data.ongoing.animeList;
      //           print('Loaded ongoing anime: ${ongoingList.length}');

      //           return ListView.builder(
      //             itemCount: ongoingList.length,
      //             itemBuilder: (context, index) {
      //               final anime = ongoingList[index];
      //               return Card(
      //                 margin: const EdgeInsets.symmetric(
      //                   horizontal: 12,
      //                   vertical: 6,
      //                 ),
      //                 child: ListTile(
      //                   title: Text(
      //                     anime.title,
      //                     style: const TextStyle(fontWeight: FontWeight.bold),
      //                   ),
      //                   subtitle: Text(
      //                     'Episodes: ${anime.episodes} • Release: ${anime.releaseDay ?? '-'}',
      //                   ),
      //                   onTap: () {
      //                     // Bisa tambahkan navigasi ke detail anime
      //                     print('Tapped on ${anime.title}');
      //                   },
      //                 ),
      //               );
      //             },
      //           );
      //         } else if (state is HomeError) {
      //           return Center(child: Text(state.message));
      //         }

      //         return const SizedBox.shrink();
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  Widget MainHeader() {
    return Stack(
      children: [
        // Container(
        //   height: 320,
        //   width: double.infinity,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         'assets/images/background-header.jpg',
        //       ), // atau .png
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        Stack(
          children: <Widget>[
            Container(
              height: 320,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/background-header.jpg',
                  ), // atau .png
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.grey.withOpacity(0.0), Colors.black],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Animplex",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.search, size: 26, color: Colors.white),
                  SizedBox(width: 10),
                  Icon(Icons.notifications, size: 26, color: Colors.white),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Demon Slayer: Kimetsu ...",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Urbanist",
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "Action, Shounen, Martial Arts",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Urbanist",
                ),
                textAlign: TextAlign.left,
              ),
              Row(
                spacing: 10,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Your button logic here
                      print('Button pressed!');
                    },
                    icon: const Icon(Icons.play_circle),
                    label: const Text('Play'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.softGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      print("Button pressed!");
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('My List'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(width: 2, color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ContentSection(String title) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "See all",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontFamily: "Urbanist",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showcaseCard({required String rating, required String number}) {
    return Stack(
      children: [
        Container(
          height: 230,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/background-header.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          bottom: 10,
          left: 10,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget showcaseCardItem({
    required BuildContext context,
    required String rating,
    required String number,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: showcaseCard(rating: rating, number: number),
    );
  }

  Widget showcaseCardList(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: showcaseCardItem(
              context: context,
              rating: "8.${index}",
              number: "${index + 1}",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => DetailPage(id: index)),
                // );
                print("Card tapped");
              },
            ),
          );
        },
      ),
    );
  }
}

//   Widget ShowcaseCard() {
//     return Stack(
//       children: [
//         Container(
//           height: 230,
//           width: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(
//               image: AssetImage(
//                 'assets/images/background-header.jpg',
//               ), // atau .png
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),

//         Positioned(
//           top: 10,
//           left: 10,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.softGreen,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Padding(
//               // padding: EdgeInsets.all(8),
//               padding: EdgeInsetsGeometry.symmetric(
//                 horizontal: 12,
//                 vertical: 6,
//               ),
//               child: Text(
//                 "8,7",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: "Urbanist",
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           bottom: 10,
//           left: 10,
//           child: Text(
//             "1",
//             style: TextStyle(
//               fontSize: 48,
//               fontFamily: "Urbanist",
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
