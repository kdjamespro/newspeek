import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_peek/screens/cov_tracker.dart';
import 'package:news_peek/screens/main_screen.dart';
import 'package:news_peek/screens/profile_screen.dart';
import 'package:news_peek/screens/search_screen.dart';
import 'package:news_peek/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int imageIndex = 0;
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 2;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final screens = [Weather(), Search(), MainScreen(), Cov_Tracker(), Profile()];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GNav(
            backgroundColor: Colors.white,
            activeColor: Colors.black,
            tabBorderRadius: 25,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabMargin: EdgeInsets.symmetric(vertical: 12.0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            iconSize: 24,
            gap: 8,
            curve: Curves.easeInSine,
            duration: Duration(milliseconds: 400),
            selectedIndex: _selectedIndex,
            tabs: const [
              GButton(
                icon: LineIcons.cloud,
                text: 'Weather',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.biohazard,
                text: 'Covid',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'User',
              ),
            ],
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

// BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// backgroundColor: Colors.white,
// showSelectedLabels: false,
// showUnselectedLabels: false,
// items: const <BottomNavigationBarItem>[
// BottomNavigationBarItem(
// icon: Icon(Icons.cloud),
// label: 'Weather',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.search),
// label: 'Search',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.home_filled),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.coronavirus),
// label: 'Virus',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.person),
// label: 'Profile',
// ),
// ],
// currentIndex: _selectedIndex,
// selectedItemColor: Colors.black,
// unselectedItemColor: Colors.grey,
// onTap: _onItemTapped,
// ),
