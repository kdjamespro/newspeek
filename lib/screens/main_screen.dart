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
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              const Text(
                'Breaking News',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.vertical,
                controller: ScrollController(initialScrollOffset: 0),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(
                      color: Colors.yellow,
                      headline:
                          'Headline ${index + 1} this is a samoke headline, headline');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
