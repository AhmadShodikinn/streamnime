import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/bloc/complete/complete_bloc.dart';
import 'package:streaming_app/bloc/complete/complete_event.dart';
import 'package:streaming_app/bloc/home/home_bloc.dart';
import 'package:streaming_app/bloc/home/home_event.dart';
import 'package:streaming_app/bloc/home/home_state.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_bloc.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_event.dart';
import 'package:streaming_app/data/models/home_anime_model.dart';
import 'package:streaming_app/data/repository/complete_anime_repository.dart';
import 'package:streaming_app/data/repository/home_anime_repository.dart';
import 'package:streaming_app/data/repository/ongoing_anime_repository.dart';
import 'package:streaming_app/presentation/completed_page.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/detail_page.dart';
import 'package:streaming_app/presentation/ongoing_page.dart';
import 'package:streaming_app/presentation/search_page.dart';
import 'package:streaming_app/presentation/widget/showcase_card.dart';
import 'package:streaming_app/presentation/widget/showcase_card_without_episode.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (_) => HomeBloc(HomeAnimeRepository())..add(FetchHomeData()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                final ongoingList = state.homeData.data.ongoing.animeList;
                final completedList = state.homeData.data.completed.animeList;

                return ListView(
                  children: [
                    MainHeader(),
                    ContentSection("Ongoing Anime", () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => OngoingPage()),
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                OngoingBloc(OngoingAnimeRepository())
                                  ..add(FetchOngoingAnimeData(1)),
                            child: const OngoingPage(),
                          ),
                        ),
                      );
                    }),
                    ongoingShowcaseList(
                      context,
                      ongoingList,
                    ), // Tampilkan list ongoing

                    ContentSection("Completed Anime", () {
                      Navigator.push(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) => CompletedPage(),
                        // ),
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                                CompleteBloc(CompleteAnimeRepository())
                                  ..add(FetchCompleteAnimeData(1)),
                            child: const CompletedPage(),
                          ),
                        ),
                      );
                    }),
                    completedShowcaseList(context, completedList),

                    SizedBox(height: 10),
                  ],
                );
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget MainHeader() {
    return Stack(
      children: [
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
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SearchPage()),
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(FontAwesomeIcons.bell, size: 20, color: Colors.white),
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
                        horizontal: 20,
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

  Widget ContentSection(String title, VoidCallback seeAll) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
            GestureDetector(
              onTap: seeAll,
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showcaseCardItem({
    required BuildContext context,
    required String animeId,
    required String poster,
    required int lastEpisode,
    String? rating,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ShowcaseCard(
        animeId: animeId,
        poster: poster,
        lastEpisode: lastEpisode,
        rating: rating,
      ),
    );
  }

  Widget ongoingShowcaseList(
    BuildContext context,
    List<HomeAnimeItem> animelist,
  ) {
    return SizedBox(
      height: 230,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: animelist.length,
          itemBuilder: (context, index) {
            final anime = animelist[index];

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(animeId: anime.animeId),
                    ),
                  );
                },
                child: ShowcaseCard(
                  animeId: anime.animeId,
                  poster: anime.poster,
                  lastEpisode: anime.episodes,
                  rating: null, // ongoing tidak punya score
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget completedShowcaseList(
    BuildContext context,
    List<HomeAnimeItem> animelist,
  ) {
    return SizedBox(
      height: 230,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: animelist.length,
          itemBuilder: (context, index) {
            final anime = animelist[index];

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(animeId: anime.animeId),
                    ),
                  );
                },
                child: ShowcaseCardWithoutEpisode(
                  poster: anime.poster,
                  rating: anime.score,
                  totalEpisode: anime.episodes,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget showcaseCardList(BuildContext context, List<HomeAnimeItem> animelist) {
  //   return SizedBox(
  //     height: 230,
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: animelist.length,
  //         itemBuilder: (context, index) {
  //           final anime = animelist[index];

  //           return Padding(
  //             padding: const EdgeInsets.only(right: 8),
  //             child: showcaseCardItem(
  //               context: context,
  //               poster: anime.poster,
  //               lastEpisode: anime.episodes,
  //               rating: anime.score,
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (_) => DetailPage()),
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
