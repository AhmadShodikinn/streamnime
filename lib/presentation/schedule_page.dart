import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaming_app/bloc/schedule/schedule_bloc.dart';
import 'package:streaming_app/bloc/schedule/schedule_event.dart';
import 'package:streaming_app/bloc/schedule/schedule_state.dart';
import 'package:streaming_app/data/models/schedule_anime_model.dart';
import 'package:streaming_app/data/repository/schedule_anime_repository.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/detail_page.dart';
import 'package:streaming_app/presentation/widget/loading_indicator.dart';
import 'package:intl/intl.dart';

class ReleasePage extends StatefulWidget {
  const ReleasePage({Key? key}) : super(key: key);

  @override
  _ReleasePageState createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage> {
  String selectedDayKey = DateFormat('EEEE').format(DateTime.now());

  final Map<String, String> dayMapping = {
    "Monday": "Senin",
    "Tuesday": "Selasa",
    "Wednesday": "Rabu",
    "Thursday": "Kamis",
    "Friday": "Jumat",
    "Saturday": "Sabtu",
    "Sunday": "Minggu",
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ScheduleBloc(ScheduleAnimeRepository())
            ..add(FetchScheduleAnimeData()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Release Anime",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              // return const Center(child: CircularProgressIndicator());
              return LoadingIndicator();
            } else if (state is ScheduleLoaded) {
              final scheduleAllDay = state.scheduleData.data;

              final selectedDayLabel = dayMapping[selectedDayKey]!;

              final selectedDayData = scheduleAllDay.firstWhere(
                (e) => e.day == selectedDayLabel,
                orElse: () =>
                    ScheduleAnimeDay(day: selectedDayLabel, animeList: []),
              );

              final animeList = selectedDayData.animeList;

              return Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: dayMapping.keys.map((key) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDayKey = key;
                                  });
                                },
                                child: CardByDay(
                                  nameOfTheDay: key, // bahasa inggris
                                  activeDay: selectedDayKey == key,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 50),
                      itemCount: animeList.length,
                      itemBuilder: (context, index) {
                        final anime = animeList[index];
                        return CardRelease(anime: anime);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ScheduleError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CardByDay extends StatelessWidget {
  final String nameOfTheDay;
  final bool activeDay;

  const CardByDay({
    Key? key,
    required this.nameOfTheDay,
    required this.activeDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: activeDay ? AppColors.softGreen : Colors.white,
        border: Border.all(
          color: activeDay ? AppColors.softGreen : AppColors.softGreen,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        nameOfTheDay,
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Urbanist",
          color: activeDay ? Colors.white : AppColors.softGreen,
          fontWeight: activeDay ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class CardRelease extends StatelessWidget {
  final ScheduleAnimeItem anime;

  const CardRelease({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(animeId: anime.slug),
                ),
              );
            },
            child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(anime.poster),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Icon(Icons.play_circle, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(animeId: anime.slug),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
