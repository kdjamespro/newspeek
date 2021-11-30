import 'package:flutter/material.dart';
import 'package:news_peek/screens/weather/current_weather.dart';
import 'package:news_peek/screens/weather/models/location.dart';

void main() {
  runApp(Weather());
}

class Weather extends StatelessWidget {
  List<Location> locations = [
    new Location(
        city: "manila", country: "philippines", lat: "14.6042", lon: "120.9822")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurrentWeatherPage(locations, context),
    );
  }
}
