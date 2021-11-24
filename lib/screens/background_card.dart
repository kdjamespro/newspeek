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
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}

// BackdropFilter(
// filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0,),
// child: Container(
// width: 200.0,
// height: 200.0,
// decoration: BoxDecoration(
// color: Colors.grey.shade200.withOpacity(0.5)
// ),
