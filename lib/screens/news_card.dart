import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_peek/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_peek/model/bookmark_db.dart';
import 'package:news_peek/services/network.dart';
import 'package:news_peek/utilities/fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share/share.dart';

class NewsCard extends StatefulWidget {
  Function? updateBookmark;
  final Article article;
  bool isBookmarked;
  NewsCard(
      {Key? key,
      required this.article,
      required this.isBookmarked,
      this.updateBookmark})
      : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  void initState() {
    setOutline();
    super.initState();
  }

  Future addBookmark(Article article) async {
    BookmarkDb.instance.save(article);
  }

  Future deleteBookmark(String title) async {
    BookmarkDb.instance.delete(title);
  }

  Future<bool> setOutline() async {
    return await BookmarkDb.instance.doesExist(widget.article.title);
  }

  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await browser.open(
          url: Uri.parse(widget.article.url),
          options: ChromeSafariBrowserClassOptions(
            android:
                AndroidChromeCustomTabsOptions(addDefaultShareMenuItem: false),
            ios: IOSSafariOptions(barCollapsingEnabled: true),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 3.7 / 3,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  padding: const EdgeInsets.all(14.0),
                  child: widget.article.imageUrl == 'No Image'
                      ? Image.asset('images/not_available.png')
                      : CachedNetworkImage(
                          imageUrl: widget.article.imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: SpinKitFoldingCube(
                              size: 60,
                              color: Colors.green,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                child: Text(
                  widget.article.title,
                  maxLines: 2,
                  style: articleTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: articleDetails,
                                  text: 'By ${widget.article.author}',
                                )),
                            const SizedBox(height: 5.0),
                            Text(
                              dateTimeFormatter(widget.article.publishedAt),
                              overflow: TextOverflow.ellipsis,
                              style: articleDetails,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 80,
                      ),
                      GestureDetector(
                          onTap: () {
                            NetworkHelper link =
                                NetworkHelper(widget.article.url);
                            String message = link.url;
                            // 'Look at this wonderful app! \n https://github.com/londonappbrewery/dicee-flutter.git';
                            RenderBox box =
                                context.findRenderObject() as RenderBox;
                            Share.share(message,
                                subject: 'This is a subject message',
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size);
                          },
                          child: Icon(
                            Icons.share,
                            size: 20,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     dateTimeFormatter(widget.article.publishedAt);
                      //   },
                      // ),
                      GestureDetector(
                        child: Container(
                          height: 20,
                          child: Icon(widget.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_outline_outlined),
                        ),
                        onTap: () async {
                          if (widget.isBookmarked) {
                            deleteBookmark(widget.article.title);
                            widget.updateBookmark == null
                                ? DoNothingAction()
                                : widget.updateBookmark!();
                            final scaffold = ScaffoldMessenger.of(context);
                            scaffold.showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 4),
                                content: Text('Bookmark Removed'),
                              ),
                            );
                          } else {
                            addBookmark(widget.article);
                            final scaffold = ScaffoldMessenger.of(context);
                            scaffold.showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 4),
                                content: Text('Bookmark Added'),
                              ),
                            );
                          }
                          setState(
                            () {
                              widget.isBookmarked = !widget.isBookmarked;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String dateTimeFormatter(String publishInfo) {
    //Date and Time together (Military time)
    String dateTimeInfo = widget.article.publishedAt;

    //Splitting date and time
    String date = dateTimeInfo.split(" ")[0];
    String time = dateTimeInfo.split(" ")[1];

    //Splitting time
    String hours = time.split(":")[0];
    String minutes = time.split(":")[1];
    String seconds = time.split(":")[2];
    int hourInt = int.parse(hours);
    String formattedTime = "";

    //
    if (hourInt > 12) {
      hourInt = hourInt - 12;
      hours = hourInt.toString();
      formattedTime = hours + ":$minutes" + " PM";
    }

    if (hourInt == 12) {
      hours = '12';
      formattedTime = hours + ":$minutes" + " AM";
    } else {
      hours = hourInt.toString();
      formattedTime = hours + ":$minutes" + " AM";
    }

    //Splitting date
    String month = date.split("-")[1];
    String days = (date.split("-")[2]);
    String years = (date.split("-")[0]);
    String formattedDate = "";

    if (month == '01') {
      month = 'Jan ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '02') {
      month = 'Feb ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '03') {
      month = 'Mar ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '04') {
      month = 'Apr ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '05') {
      month = 'May ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '06') {
      month = 'Jun ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '07') {
      month = 'Jul ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '08') {
      month = 'Aug ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '09') {
      month = 'Sept ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '10') {
      month = 'Oct ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '11') {
      month = 'Nov ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    if (month == '12') {
      month = 'Dec ';
      formattedDate = (month + "$days, " + years + "    " + formattedTime);
    }
    return formattedDate;
  }
}
