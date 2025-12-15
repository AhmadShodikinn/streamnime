import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class OngoingPage extends StatefulWidget {
  const OngoingPage({Key? key}) : super(key: key);

  @override
  _OngoingPageState createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Ongoing Anime",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search), // The icon itself
            tooltip: 'Searcn', // The tooltip for long press/hover
            onPressed: () {
              // Define the action to perform when the icon is pressed
              print('button pressed!');
            },
          ),
        ],
      ),
      body: SectionCard(),
    );
  }

  Widget SectionCard() {
    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowcaseCard(),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Attack on Titan Final Season Part 2",
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
                    "2022 | Japan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist",
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Genre: Action, Fiction, Dark Fantasy, Apocalyptic, Drama, Shounen, ...",
                      style: TextStyle(fontSize: 14, fontFamily: "Urbanist"),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('Button pressed!');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('My List'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.softGreen,
                      foregroundColor: Colors.white,
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

  Widget ShowcaseCard() {
    return Stack(
      children: [
        Container(
          height: 220,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/background-header.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                "8.7",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 15,
          child: Text(
            "1",
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
