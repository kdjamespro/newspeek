import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/model/article.dart';
import 'package:news_peek/model/bookmark_db.dart';
import 'package:news_peek/utilities/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'news_card.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  late Future<List<Article>> bookmarks;

  Future getBookmarks() async {
    bookmarks = BookmarkDb.instance.getBookmarks();
  }

  Future updateBookmarks() async {
    setState(() {
      bookmarks = BookmarkDb.instance.getBookmarks();
    });
  }

  @override
  void initState() {
    getBookmarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Saved Bookmarks',
                    style: headerTitle,
                  ),
                ),
                FutureBuilder(
                    future: bookmarks,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Cannot Load the Data'));
                        } else {
                          List<Article> bookmarks = snapshot.data ?? [];
                          if (bookmarks.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 60),
                                  child: SvgPicture.asset(
                                    'images/add_bookmark.svg',
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      'Add Bookmark',
                                      style: headerTitle,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      'Don\'t forget the save articles you like or want to read later',
                                      textAlign: TextAlign.center,
                                      style: subTitle,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Scrollbar(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: bookmarks.length,
                                scrollDirection: Axis.vertical,
                                controller:
                                    ScrollController(initialScrollOffset: 0),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 10.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return NewsCard(
                                    article: bookmarks[index],
                                    isBookmarked: true,
                                    updateBookmark: updateBookmarks,
                                  );
                                },
                              ),
                            );
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
