import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                "My List",
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
              FontAwesomeIcons.ellipsis,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [ProfileCard(), PremiumTag()]),
      ),
    );
  }

  Widget ProfileCard() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.softGreen,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/background-header.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Container(
                color: AppColors.softGreen,
                height: 50,
                width: 50,
                child: Icon(FontAwesomeIcons.pen, size: 20),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Kuchiba Chisa",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Kuchibachisa@example.co.id",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget PremiumTag() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.softGreen, width: 1),
      ),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.crown, size: 50, color: AppColors.softGreen),
          Column(
            children: [
              Text(
                "Join Premium!",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Enjoy watching Full-HD animes, without restrictions and without ads",
                maxLines: 2,
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            FontAwesomeIcons.angleRight,
            size: 30,
            color: AppColors.softGreen,
          ),
        ],
      ),
    );
  }

  Widget ListTileMenu() {
    return Row();
  }
}
