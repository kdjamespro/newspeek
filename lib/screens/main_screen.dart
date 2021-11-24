import 'package:flutter/material.dart';
import 'package:news_peek/screens/news_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Breaking News'),
            const SizedBox(width: 40.0),
            NewsCard(
                color: Colors.yellow,
                headline: 'Headline1 this is a samoke headline, headline'),
            NewsCard(
              color: Colors.blue,
              headline: 'Headline2 this is a samoke headline, headline',
            ),
          ],
        ),
      ),
    );
  }
}
