import 'package:flutter/material.dart';

class HeadlineCard extends StatelessWidget {
  HeadlineCard({required this.image});

  final AssetImage image;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}

// boxShadow: [
// BoxShadow(
// color: Colors.black.withOpacity(0.3),
// spreadRadius: 5,
// blurRadius: 10,
// offset: Offset(0, 5),
// ),
// ]
