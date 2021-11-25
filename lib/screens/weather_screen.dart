import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: Center(
                child: Text(
              "Weather",
              style: TextStyle(fontSize: 100),
            )),
          ),
        ),
      ),
    );
  }
}
