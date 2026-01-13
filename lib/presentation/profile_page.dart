import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
          titleSpacing: 0,
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            ProfileCard(),
            Divider(),
            PremiumTag(),
            Divider(),
            Expanded(child: ListMenu()),
          ],
        ),
      ),
    );
  }

  Widget Divider() {
    return SizedBox(height: 20);
  }

  Widget ProfileCard() {
    return Row(
      spacing: 15,
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
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),

                  color: AppColors.softGreen,
                ),
                child: Icon(
                  FontAwesomeIcons.pen,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                fontSize: 18,
                color: Colors.grey,
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
        border: Border.all(color: AppColors.softGreen, width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(FontAwesomeIcons.crown, size: 40, color: AppColors.softGreen),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    "Join Premium!",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softGreen,
                    ),
                  ),
                  Text(
                    "Enjoy watching Full-HD animes, without restrictions and without ads",
                    maxLines: 2,

                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 15,
                      color: Colors.grey,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              FontAwesomeIcons.angleRight,
              size: 20,
              color: AppColors.softGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget ListTileMenu(
    IconData fontAwesomeicon,
    String title,
    bool isToggle,
    bool isLanguage,
    bool isExit,
  ) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 15,
            children: [
              Icon(
                fontAwesomeicon,
                size: 20,
                color: isExit ? AppColors.softRed : AppColors.softBlack,
              ),
              Text(
                // "Edit Profile",
                title,
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isExit ? AppColors.softRed : AppColors.softBlack,
                ),
              ),
            ],
          ),
          Row(
            spacing: 15,
            children: [
              if (isLanguage)
                Text(
                  "English (US)",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isExit)
                isToggle
                    ? CupertinoSwitch(
                        value: false,
                        onChanged: (value) {
                          setState(() {});
                        },
                      )
                    : Icon(FontAwesomeIcons.angleRight, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget ListMenu() {
    return ListView(
      padding: EdgeInsetsGeometry.only(bottom: 15),

      physics: BouncingScrollPhysics(),
      children: [
        ListTileMenu(
          FontAwesomeIcons.user,
          "Edit Profile",
          false,
          false,
          false,
        ),
        ListTileMenu(
          FontAwesomeIcons.bell,
          "Notification",
          false,
          false,
          false,
        ),
        ListTileMenu(
          FontAwesomeIcons.download,
          "Download",
          false,
          false,
          false,
        ),
        ListTileMenu(FontAwesomeIcons.shield, "Security", false, false, false),
        ListTileMenu(
          FontAwesomeIcons.earthAmericas,
          "Language",
          false,
          true,
          false,
        ),
        ListTileMenu(FontAwesomeIcons.eye, "Dark Mode", true, false, false),
        ListTileMenu(
          FontAwesomeIcons.circleInfo,
          "Help Center",
          false,
          false,
          false,
        ),
        ListTileMenu(
          FontAwesomeIcons.circleInfo,
          "Privacy Policy",
          false,
          false,
          false,
        ),
        ListTileMenu(
          FontAwesomeIcons.rightFromBracket,
          "Logout",
          false,
          false,
          true,
        ),
      ],
    );
  }
}
