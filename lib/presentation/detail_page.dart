import 'dart:ui';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/bloc/detail/detail_bloc.dart';
import 'package:streaming_app/bloc/detail/detail_event.dart';
import 'package:streaming_app/bloc/detail/detail_state.dart';
import 'package:streaming_app/data/models/detail_anime_model.dart';
import 'package:streaming_app/data/models/saved_anime_model.dart';
import 'package:streaming_app/data/repository/detail_anime_repository.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/helper/get_season_anime.dart';
import 'package:streaming_app/presentation/preferences_page.dart';
import 'package:streaming_app/presentation/video_player_page.dart';
import 'package:streaming_app/presentation/widget/loading_indicator.dart';

//sqlite
import 'package:streaming_app/data/database/anime_database.dart';

class DetailPage extends StatefulWidget {
  final String animeId;
  const DetailPage({Key? key, required this.animeId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    final result = await AnimeDatabase.instance.isSaved(widget.animeId);

    setState(() {
      isBookmarked = result;
    });
  }

  Future<void> _toggleBookmark(DetailAnimeData anime) async {
    final db = AnimeDatabase.instance;

    if (isBookmarked) {
      await db.removeSavedAnime(widget.animeId);
    } else {
      await db.saveAnime(
        SavedAnimeModel(
          animeId: widget.animeId,
          title: anime.title,
          poster: anime.poster,
          episodes: anime.episodeList.length,
          score: anime.score,
          lastReleaseDate: "Mei 12, 2024",
          href: "/anime",
          otakudesuUrl: "https://otakudesu.best",
        ),
      );
    }

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DetailBloc(DetailAnimeRepository())
            ..add(FetchDetailAnimeData(widget.animeId)),
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(0.0),
        //   child: AppBar(
        //     backgroundColor: Colors.green.shade50,
        //     // You can still use AppBar properties here if needed,
        //     // but the bar itself will not be visible due to the zero height.
        //     // title: const Text('Hidden App Bar'),
        //   ),
        // ),
        backgroundColor: Colors.white,
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              return LoadingIndicator();
            } else if (state is DetailLoaded) {
              final detailList = state.detailAnimeModel.data;
              final poster = state.detailAnimeModel.data.poster;
              final recomendedList =
                  state.detailAnimeModel.data.recommendedAnimeList;
              final episodeList = state.detailAnimeModel.data.episodeList;

              print(episodeList.first.toString());

              final title = state.detailAnimeModel.data.title;
              final seasonInfo = getAnimeSeason(title);

              return Padding(
                padding: EdgeInsetsGeometry.zero,
                child: ListView(
                  children: [
                    ShowcaseHeaderDetail(poster),
                    ShowcaseInformationDetail(detailList),
                    ShowcaseInformationEpisodes(
                      poster,
                      episodeList,
                      seasonInfo,
                    ),
                    PreferencesPage(recommendedAnimeList: recomendedList),
                  ],
                ),
              );
            } else if (state is DetailError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Oops!",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Urbanist",
                        color: AppColors.softRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "It looks like you don't have a connection.",
                      style: TextStyle(fontSize: 18, fontFamily: "Urbanist"),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // header images
  Widget ShowcaseHeaderDetail(String poster) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Stack(
              children: [
                Positioned(
                  child: Center(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poster),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 15,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 15,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cast),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // information detail
  Widget ShowcaseInformationDetail(DetailAnimeData animeList) {
    String aired = animeList.aired;
    String trimAired = aired.split(',').last.trim();

    final String genres = animeList.genreList
        .map((genreList) => genreList.title)
        .join(', ');

    return Container(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          spacing: 15,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    animeList.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Urbanist",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
                  child: Row(
                    spacing: 20,
                    children: [
                      // kalo pakai icon only
                      GestureDetector(
                        onTap: () {
                          _toggleBookmark(animeList);
                        },
                        child: Icon(
                          isBookmarked
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark,
                          size: 18,
                          color: isBookmarked
                              ? AppColors.softGreen
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.paperPlane,
                        size: 18,
                        color: Colors.black,
                      ),

                      // kalau pakai iconbutton
                      // IconButton(
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () => _toggleBookmark(animeList),
                      //   icon: Icon(
                      //     isBookmarked
                      //         ? FontAwesomeIcons.solidBookmark
                      //         : FontAwesomeIcons.bookmark,
                      //     size: 18,
                      //     color: isBookmarked
                      //         ? AppColors.softGreen
                      //         : Colors.black,
                      //   ),
                      // ),
                      // IconButton(
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () => _toggleBookmark(animeList),
                      //   icon: Icon(
                      //     FontAwesomeIcons.paperPlane,
                      //     size: 18,
                      //     color: Colors.black,
                      //   ),
                      // ),

                      // pakai baseline
                      // Baseline(
                      //   baseline: 24,
                      //   baselineType: TextBaseline.alphabetic,
                      //   child: IconButton(
                      //     padding: EdgeInsets.zero,
                      //     onPressed: () => _toggleBookmark(animeList),
                      //     icon: Icon(
                      //       isBookmarked
                      //           ? FontAwesomeIcons.solidBookmark
                      //           : FontAwesomeIcons.bookmark,
                      //       size: 18,
                      //       color: isBookmarked
                      //           ? AppColors.softGreen
                      //           : Colors.black,
                      //     ),
                      //   ),
                      // ),

                      // Baseline(
                      //   baseline: 24,
                      //   baselineType: TextBaseline.alphabetic,
                      //   child: IconButton(
                      //     padding: EdgeInsets.zero,
                      //     onPressed: () => _toggleBookmark(animeList),
                      //     icon: Icon(
                      //       FontAwesomeIcons.paperPlane,
                      //       size: 18,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Icon(
                  FontAwesomeIcons.solidStarHalfStroke,
                  size: 16,
                  color: AppColors.softGreen,
                ),
                Text(
                  animeList.score != "" ? animeList.score : 'None',
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
                  trimAired,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Urbanist",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                            epsId: animeList.episodeList.last.episodeId,
                            poster: animeList.poster,
                            title: animeList.episodeList.last.title,
                          ),
                        ),
                      );
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
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(right: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  genres,
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            ExpandableText(
              animeList.synopsis.paragraphs.join(' '),
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
  Widget ShowcaseInformationEpisodes(
    String poster,
    List<EpisodeItem> episodeList,
    int season,
  ) {
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
                    "Season $season",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.softGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ShowcaseEpisodeList(context, poster, episodeList),
      ],
    );
  }

  // showcase episode list
  Widget ShowcaseEpisodeList(
    BuildContext context,
    String poster,
    List<EpisodeItem> episodeList,
  ) {
    final reverseEpisodeList = episodeList.reversed.toList();

    return SizedBox(
      height: 110,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 15),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: reverseEpisodeList.length,
          itemBuilder: (context, index) {
            final anime = reverseEpisodeList[index];

            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CardEpisodeShowcase(
                poster,
                anime.title,
                anime.eps,
                anime.episodeId,
              ),
            );
          },
        ),
      ),
    );
  }

  // card episodes
  Widget CardEpisodeShowcase(
    String poster,
    String title,
    int eps,
    String episodeid,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VideoPlayerPage(epsId: episodeid, poster: poster, title: title),
          ),
        );
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(poster),
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
                "Episode $eps",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
