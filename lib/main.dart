import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../screens/cov_tracker.dart';
import '../screens/main_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/search_screen.dart';
import '../screens/weather_screen.dart';
import 'dart:io' show Platform;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

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

  final screens = [
    Weather(),
    Search(),
    MainScreen(),
    Cov_Tracker(),
    Bookmarks()
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
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
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: screens,
          onPageChanged: _onItemTapped,
        ),
        bottomNavigationBar: GNav(
          color: Colors.grey[600],
          tabBackgroundColor: Colors.grey.shade900,
          backgroundColor: Colors.white70,
          activeColor: Colors.white,
          tabBorderRadius: 25,
          //          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabMargin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          iconSize: 24,
          gap: 8,
          curve: Curves.easeInSine,
          duration: Duration(milliseconds: 400),
          selectedIndex: _selectedIndex,
          tabs: const [
            GButton(
              icon: LineIcons.cloud,
              text: 'Weather',
              backgroundColor: Colors.blueAccent,
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
              backgroundColor: Colors.green,
            ),
            GButton(
              icon: LineIcons.home,
              text: 'Home',
              backgroundColor: Colors.red,
            ),
            GButton(
              icon: LineIcons.firstAid,
              text: 'Covid',
              backgroundColor: Colors.pinkAccent,
            ),
            GButton(
              icon: LineIcons.bookmark,
              text: 'Bookmarks',
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
          onTabChange: _onItemTapped,
        ),
      ),
    );
  }
}
