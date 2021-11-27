import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_peek/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_peek/utilities/fonts.dart';

class HeadlineCard extends StatelessWidget {
  HeadlineCard({required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: article.imageUrl == 'No Image'
                ? AssetImage('images/test0.jpg') as ImageProvider
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
    );
  }
}
