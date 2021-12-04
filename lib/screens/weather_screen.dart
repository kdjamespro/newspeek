import 'package:flutter/material.dart';
import 'package:news_peek/screens/weather/current_weather.dart';
import 'package:news_peek/screens/weather/models/location.dart';

void main() {
  runApp(WeatherScreen());
}

class WeatherScreen extends StatelessWidget {
  List<Location> locations = [
    Location(
        city: "manila",
        country: "philippines",
        lat: "14.6042",
        lon: "120.9822"),
    Location(
        city: "cebu", country: "philippines", lat: "10.3167", lon: "123.8907"),
    Location(
        city: "davao", country: "philippines", lat: "6.813", lon: "125.7085"),
    Location(city: "milan", country: "italy", lat: "45.4643", lon: "9.1895"),
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
