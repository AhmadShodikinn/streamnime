import 'package:flutter/material.dart';
import 'package:streaming_app/presentation/constant/app_colors.dart';
import 'package:streaming_app/presentation/main_page.dart';

class LayoutNavbar extends StatefulWidget {
  @override
  _LayoutNavbarState createState() => _LayoutNavbarState();
}

class _LayoutNavbarState extends State<LayoutNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    Center(child: Text('Halaman Menu 2')),
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
        // decoration: BoxDecoration(
        //   color: Colors.white.withOpacity(0.95),
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(30),
        //     topRight: Radius.circular(30),
        //   ),
        //   boxShadow: [
        //     BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 15),
        //   ],
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            // selectedItemColor: Colors.amber,
            selectedItemColor: AppColors.softGreen,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                label: 'Release',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'My List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: 'Download',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget get bodyContent {
  //   return MainPage();
  // }

  // Widget get bottomNavigationBar {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(30),
  //       topRight: Radius.circular(30),
  //     ),
  //     child: BottomNavigationBar(
  //       showSelectedLabels: true,
  //       showUnselectedLabels: true,
  //       type: BottomNavigationBarType.fixed,
  //       // selectedItemColor: Colors.amber,
  //       selectedItemColor: AppColors.softGreen,
  //       unselectedItemColor: Colors.grey,
  //       currentIndex: _currentIndex,
  //       onTap: (index) {
  //         setState(() {
  //           _currentIndex = index;
  //         });
  //       },
  //       items: const [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.date_range),
  //           label: 'Release',
  //         ),
  //         BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'My List'),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.download),
  //           label: 'Download',
  //         ),
  //         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  //       ],
  //     ),
  //   );
  // }
}
