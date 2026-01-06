import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ReleasePage extends StatefulWidget {
  const ReleasePage({Key? key}) : super(key: key);

  @override
  _ReleasePageState createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage> {
  String selectedDay = "Tuesday";

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
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
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: days.map((day) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = day;
                          });
                        },
                        child: CardByDay(
                          nameOfTheDay: day,
                          activeDay: selectedDay == day,
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
              //perlu dibenerin
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CardRelease();
              },
            ),
          ),

          SizedBox(height: 10),
        ],
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
          color: activeDay ? AppColors.softGreen : Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        nameOfTheDay,
        style: TextStyle(
          fontSize: 14,
          color: activeDay ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

class CardRelease extends StatelessWidget {
  const CardRelease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://otakudesu.best/wp-content/uploads/2026/01/154763.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Icon(Icons.play_circle, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Toujima Tanzaburou wa Kamen Rider ni Naritai",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
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
