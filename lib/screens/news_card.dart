import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  NewsCard({required this.headline, required this.image});

  final String headline;
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'By Zachariah Kelly',
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '2021-11-24 06:14:06',
                      ),
                    ],
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
    );
  }
}
