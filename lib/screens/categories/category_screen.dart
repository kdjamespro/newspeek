import 'package:flutter/material.dart';
import 'package:news_peek/model/article.dart';
import 'package:news_peek/services/news.dart';

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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    generator = NewsModel();
    news = generator.getCategoryHeadlines(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: news,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Cannot Load the Data'));
            } else {
              List<Article> articles = snapshot.data ?? [];
              List<Article> headlines = articles.sublist(0, 3);
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
                        return NewsCard(article: articles[index + 3]);
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
