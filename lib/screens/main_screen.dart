import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_peek/model/article.dart';
import 'package:news_peek/model/bookmark_db.dart';
import 'package:news_peek/screens/headline_card.dart';
import 'package:news_peek/screens/news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_peek/services/news.dart';
import 'package:news_peek/utilities/fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List images = ['images/test0.jpg', 'images/test1.jpg', 'images/test2.jpg'];

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  int imageIndex = 0;
  late NewsModel generator;
  late Future<List<Article>> news;
  late List<Article> bookmarks = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    generator = NewsModel();
    news = generator.getCountryHeadlines('ph');
    getBookmarks();
    super.initState();
  }

  Future getBookmarks() async {
    bookmarks = await BookmarkDb.instance.getBookmarks();
  }

  bool contains(Article article) {
    var contains =
        bookmarks.firstWhereOrNull((item) => item.title == article.title);
    return contains != null;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: news,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitFoldingCube(
                  size: 60,
                  color: Colors.red,
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: SvgPicture.asset(
                          'images/no_data.svg',
                          width: MediaQuery.of(context).size.width / 1.9,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Center(
                          child: Text(
                            'No Data Found',
                            style: headerTitle,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: Text(
                              'Check if your connected to the internet. If yes, there might be a problem on the server',
                              textAlign: TextAlign.center,
                              style: subTitle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                List<Article> articles = snapshot.data ?? [];
                List<Article> headlines = articles.sublist(0, 3);
                return Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2.1,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
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
                                            MediaQuery.of(context).size.height /
                                                2.2,
                                        onPageChanged: (index, reason) =>
                                            setState(() {
                                          imageIndex = index;
                                        }),
                                      ),
                                      items: headlines.map(
                                        (headline) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return HeadlineCard(
                                                article: headline,
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
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          'Breaking News',
                          style: headerTitle,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: articles.length < 10 ? articles.length : 13,
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(initialScrollOffset: 0),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          return NewsCard(
                              article: articles[index + 3],
                              isBookmarked: contains(articles[index + 3]));
                        },
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget CircleIndicator() => AnimatedSmoothIndicator(
        activeIndex: imageIndex,
        count: images.length,
        effect: const WormEffect(
          dotHeight: 8.0,
        ),
      );
}
