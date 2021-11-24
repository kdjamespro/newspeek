import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

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
              '''Cathie Wood testing 'ARK on steroids' short strategy, backs Zoom, Tesla and Bitcoin''',
              style: GoogleFonts.oswald(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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

// BackdropFilter(
// filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
// child: Container(
// width: 200.0,
// height: 200.0,
// decoration: BoxDecoration(
// color: Colors.grey.shade200.withOpacity(0.5)
// ),
