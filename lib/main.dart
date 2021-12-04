import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_peek/utilities/fonts.dart';
import '../screens/cov_tracker.dart';
import '../screens/main_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/search_screen.dart';
import '../screens/weather_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:io' show Platform;

import 'my_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //     Duration(seconds: 2),
  //     () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => MainContent(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromARGB(1, 251, 251, 251),
        body: AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "images/loading_splash.gif",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Newspeek",
                style: headerTitle,
              ),
            ],
          ),
          nextScreen: MainContent(),
          backgroundColor: Color.fromARGB(1, 251, 251, 251),
          splashIconSize: 300,
        ),
      ),
    );
  }
}
