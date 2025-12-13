import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/home/home_bloc.dart';
import 'package:streaming_app/bloc/home/home_event.dart';
import 'package:streaming_app/bloc/home/home_state.dart';
import 'package:streaming_app/data/repository/home_anime_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(padding: EdgeInsets.zero, children: [MainHeader()]),
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
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
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

  Widget ContentSection() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Ongoing Anime"), Text("See all")],
        ),
      ),
    );
  }
}
