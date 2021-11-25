import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cov_Tracker extends StatelessWidget {
  const Cov_Tracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: Center(
                child: Text(
              "Cov Tracker",
              style: TextStyle(fontSize: 100),
            )),
          ),
        ),
      ),
    );
  }
}
