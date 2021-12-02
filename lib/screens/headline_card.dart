import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_peek/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_peek/utilities/fonts.dart';

class HeadlineCard extends StatelessWidget {
  HeadlineCard({required this.article});
  final Article article;
  final ChromeSafariBrowser browser = ChromeSafariBrowser();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: article.imageUrl == 'No Image'
                  ? const AssetImage('images/not_available.png')
                      as ImageProvider
                  : CachedNetworkImageProvider(article.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Align(
            alignment: FractionalOffset.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(10.0),
              child: Text(
                article.title,
                style: headerTitle,
              ),
            ),
          ),
        ),
      ),
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
    );
  }
}
