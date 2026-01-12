import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/search_page.dart';

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0, // biar rapi ke kiri
          title: Row(
            children: [
              Image.asset(
                'assets/images/Animplex.png',
                height: 24, // icon size
              ),
              const SizedBox(width: 8),
              const Text(
                "Download",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchPage()),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 5),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Download is Empty",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Urbanist",
                  color: AppColors.softGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Looks like you haven't downloaded \n  anime at all",
                maxLines: 2,
                style: TextStyle(fontSize: 18, fontFamily: "Urbanist"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
