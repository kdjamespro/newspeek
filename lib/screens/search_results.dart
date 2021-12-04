import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_peek/model/article.dart';
import 'package:news_peek/model/bookmark_db.dart';
import 'package:news_peek/services/news.dart';
import 'package:collection/collection.dart';
import 'package:news_peek/utilities/fonts.dart';

import 'news_card.dart';

class SearchResults extends StatefulWidget {
  late String keyword;
  SearchResults({Key? key, required this.keyword}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late NewsModel generator;
  late Future<List<Article>> news;
  late List<Article> bookmarks;

  @override
  void initState() {
    generator = NewsModel();
    news = generator.getNewsAbout(widget.keyword);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
          future: news,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitFoldingCube(
                  size: 60,
                  color: Colors.green,
                ),
              );
            } else {
              if (snapshot.hasError) {
                return const Center(child: Text('Cannot Load the Data'));
              } else {
                List<Article> articles = snapshot.data ?? [];
                if (articles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            'images/lost.svg',
                            width: MediaQuery.of(context).size.width / 1.3,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              'No results',
                              style: headerTitle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              'Try to enter another keyword for your search query',
                              textAlign: TextAlign.center,
                              style: subTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Scrollbar(
                    child: ListView(
                      children: <Widget>[
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              articles.length < 10 ? articles.length : 10,
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
            }
          }),
    );
  }
}
