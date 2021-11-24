import 'package:flutter/material.dart';
import 'dart:ui';

class BackgroundCard extends StatelessWidget {
  BackgroundCard({required this.image});

  final AssetImage image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
