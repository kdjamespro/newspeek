import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_peek/utilities/fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsCard extends StatelessWidget {
  NewsCard({required this.article});
  final Article article;
  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await browser.open(
          url: Uri.parse(article.url),
          options: ChromeSafariBrowserClassOptions(
            android:
                AndroidChromeCustomTabsOptions(addDefaultShareMenuItem: false),
            ios: IOSSafariOptions(barCollapsingEnabled: true),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 4 / 3,
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
                  child: article.imageUrl == 'No Image'
                      ? Image.asset('images/not_available.png')
                      : CachedNetworkImage(
                          imageUrl: article.imageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                  article.title,
                  maxLines: 2,
                  style: articleTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: articleDetails,
                                text: 'By ${article.author}',
                              )),
                          SizedBox(height: 5.0),
                          Text(
                            article.publishedAt,
                            overflow: TextOverflow.ellipsis,
                            style: articleDetails,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.share),
                    Icon(Icons.bookmark),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
