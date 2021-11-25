import 'package:flutter/material.dart';
import 'package:news_peek/screens/background_card.dart';
import 'package:news_peek/screens/cov_tracker.dart';
import 'package:news_peek/screens/headline_card.dart';
import 'package:news_peek/screens/news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_peek/screens/profile_screen.dart';
import 'package:news_peek/screens/search_screen.dart';
import 'package:news_peek/screens/weather_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List images = ['images/test0.jpg', 'images/test1.jpg', 'images/test2.jpg'];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                      child: BackgroundCard(
                        image: AssetImage(images[imageIndex]),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  height:
                                      MediaQuery.of(context).size.height / 2.2,
                                  onPageChanged: (index, reason) =>
                                      setState(() => imageIndex = index)),
                              items: images.map(
                                (image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return HeadlineCard(
                                        image: AssetImage(image),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                            CircleIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const Text(
                  'Breaking News',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                scrollDirection: Axis.vertical,
                controller: ScrollController(initialScrollOffset: 0),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(
                      image: AssetImage(images[index]),
                      headline:
                          'Headline ${index + 1} this is a samoke headline, headline');
                },
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget CircleIndicator() => AnimatedSmoothIndicator(
        activeIndex: imageIndex,
        count: images.length,
        effect: WormEffect(
          dotHeight: 8.0,
        ),
      );
}
