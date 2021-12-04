import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_peek/model/article.dart';
import 'package:news_peek/model/bookmark_db.dart';
import 'package:news_peek/services/news.dart';
import 'package:collection/collection.dart';
import 'package:news_peek/utilities/fonts.dart';
import '../news_card.dart';

class CategoryPage extends StatefulWidget {
  late String category;
  CategoryPage({required this.category, Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  late NewsModel generator;
  late Future<List<Article>> news;
  late List<Article> bookmarks;

  @override
  bool get wantKeepAlive => true;

  Future updateBookmarks() async {
    setState(() async {
      bookmarks = await BookmarkDb.instance.getBookmarks();
    });
  }

  @override
  void initState() {
    generator = NewsModel();
    news = generator.getCategoryHeadlines(widget.category);
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: news,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFoldingCube(
                size: 60,
                color: Colors.green,
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
              return Scrollbar(
                child: ListView(
                  children: <Widget>[
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: articles.length < 10 ? articles.length : 10,
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(initialScrollOffset: 0),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCard(
                            article: articles[index],
                            isBookmarked: contains(articles[index]));
                      },
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              );
            }
          }
        });
  }
}
