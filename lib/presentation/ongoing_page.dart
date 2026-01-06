import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_bloc.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_event.dart';
import 'package:streaming_app/bloc/ongoing/ongoing_state.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/detail_page.dart';

class OngoingPage extends StatefulWidget {
  const OngoingPage({Key? key}) : super(key: key);

  @override
  _OngoingPageState createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<OngoingBloc>().add(FetchMoreOngoingAnimeData());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Ongoing Anime",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<OngoingBloc, OngoingState>(
        builder: (context, state) {
          if (state is OngoingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OngoingLoaded) {
            final ongoingList = state.ongoingData.data.animeList;

            return ListView.builder(
              controller: _scrollController,
              itemCount: ongoingList.length,
              itemBuilder: (context, index) {
                final animeData = ongoingList[index];
                return SectionCard(
                  animeId: animeData.animeId,
                  title: animeData.title,
                  poster: animeData.poster,
                  lastEpisode: animeData.episodes.toString(),
                  lastReleaseDate: animeData.latestReleaseDate,
                  releaseDay: animeData.releaseDay,
                );
              },
            );
          } else if (state is OngoingError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (_) =>
  //         OngoingBloc(OngoingAnimeRepository())..add(FetchOngoingAnimeData(1)),
  //     child: Scaffold(
  //       backgroundColor: Colors.white,
  //       appBar: AppBar(
  //         backgroundColor: Colors.white,
  //         elevation: 0,
  //         titleSpacing: 0,
  //         iconTheme: IconThemeData(color: Colors.black),
  //         title: const Text(
  //           "Ongoing Anime",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontFamily: "Urbanist",
  //             fontSize: 24,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         actions: <Widget>[
  //           IconButton(
  //             icon: const Icon(Icons.search), // The icon itself
  //             tooltip: 'Searcn', // The tooltip for long press/hover
  //             onPressed: () {
  //               // Define the action to perform when the icon is pressed
  //               print('button pressed!');
  //             },
  //           ),
  //         ],
  //       ),
  //       body: BlocBuilder<OngoingBloc, OngoingState>(
  //         builder: (context, state) {
  //           if (state is OngoingLoading) {
  //             return const Center(child: CircularProgressIndicator());
  //           } else if (state is OngoingLoaded) {
  //             final ongoingList = state.ongoingData.data.animeList;

  //             return ListView.builder(
  //               controller: _scrollController,
  //               scrollDirection: Axis.vertical,
  //               itemCount: ongoingList.length,
  //               itemBuilder: (context, index) {
  //                 final animeData = ongoingList[index];

  //                 return SectionCard(
  //                   title: animeData.title,
  //                   poster: animeData.poster,
  //                   lastEpisode: animeData.episodes.toString(),
  //                   lastReleaseDate: animeData.latestReleaseDate,
  //                   releaseDay: animeData.releaseDay,
  //                 );
  //               },
  //             );
  //           } else if (state is OngoingError) {
  //             return Center(child: Text(state.message));
  //           }

  //           return const SizedBox.shrink();
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget SectionCard({
    required String animeId,
    required String title,
    required String poster,
    required String lastEpisode,
    required String releaseDay,
    required String lastReleaseDate,
  }) {
    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowcaseCard(poster: poster, episode: lastEpisode),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Urbanist",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Terakhir update: $lastReleaseDate",
                    style: TextStyle(fontSize: 16, fontFamily: "Urbanist"),
                  ),
                  // Flexible(
                  //   child: Text(
                  //     "Genre: Action, Fiction, Dark Fantasy, Apocalyptic, Drama, Shounen, ...",
                  //     style: TextStyle(fontSize: 14, fontFamily: "Urbanist"),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Your button logic here
                        // print('Button pressed!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(animeId: animeId),
                          ),
                        );
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ShowcaseCard({required String episode, required String poster}) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: 220,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(poster),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Positioned(
        //   top: 15,
        //   left: 15,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: AppColors.softGreen,
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //       child: Text(
        //         "8.7",
        //         style: TextStyle(
        //           fontSize: 14,
        //           fontFamily: "Urbanist",
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 15,
          left: 15,
          child: Text(
            episode,
            style: TextStyle(
              fontSize: 48,
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
