import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/main_page.dart';
import 'package:streaming_app/presentation/schedule_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LayoutNavbar extends StatefulWidget {
  @override
  _LayoutNavbarState createState() => _LayoutNavbarState();
}

class _LayoutNavbarState extends State<LayoutNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    ReleasePage(),
    Center(child: Text('Halaman Menu 3')),
    Center(child: Text('Halaman Menu 4')),
    Center(child: Text('Halaman Menu 5')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: <Widget>[
      //     bodyContent,
      //     Positioned(left: 0, right: 0, bottom: 0, child: bottomNavigationBar),
      //   ],
      // ),
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.95),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            // selectedItemColor: Colors.amber,
            selectedItemColor: AppColors.softGreen,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(
              fontFamily: "Urbanist",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Urbanist",
              fontSize: 14,
            ),
            selectedIconTheme: IconThemeData(size: 22),
            unselectedIconTheme: IconThemeData(size: 22),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                // icon: Icon(Icons.home),
                icon: FaIcon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.date_range),
                icon: FaIcon(FontAwesomeIcons.calendarDays),
                label: 'Release',
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.bookmark),
                icon: FaIcon(FontAwesomeIcons.bookmark),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.download),
                icon: FaIcon(FontAwesomeIcons.download),
                label: 'Download',
              ),
              BottomNavigationBarItem(
                // icon: Icon(Icons.person),
                icon: FaIcon(FontAwesomeIcons.user),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
