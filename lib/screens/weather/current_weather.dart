import 'package:flutter/material.dart';
import 'package:news_peek/screens/weather/models/forecast.dart';
import 'package:news_peek/screens/weather/models/location.dart';
import 'package:news_peek/screens/weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'extensions.dart';
import 'package:intl/intl.dart';

class CurrentWeatherPage extends StatefulWidget {
  final List<Location> locations;
  final BuildContext context;
  const CurrentWeatherPage(this.locations, this.context);

  @override
  _CurrentWeatherPageState createState() =>
      _CurrentWeatherPageState(locations, context);
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  final List<Location> locations;
  final Location location;
  @override
  final BuildContext context;
  _CurrentWeatherPageState(this.locations, this.context)
      : location = locations[0];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      currentWeatherViews(locations, location, this.context),
      forecastViewsHourly(location),
      forecastViewsDaily(location),
    ]));
  }
}

Widget currentWeatherViews(
    List<Location> locations, Location location, BuildContext context) {
  Weather? _weather;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weather = snapshot.data as Weather?;
        if (_weather == null) {
          return const Text("Error getting weather");
        } else {
          return Column(children: [
            createAppBar(locations, location, context),
            weatherBox(_weather!),
            weatherDetailsBox(_weather!),
          ]);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: getCurrentWeather(location),
  );
}

Widget forecastViewsHourly(Location location) {
  Forecast? _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data as Forecast?;
        if (_forecast == null) {
          return const Text("Error getting weather");
        } else {
          return hourlyBoxes(_forecast!);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget forecastViewsDaily(Location location) {
  Forecast? _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data as Forecast?;
        if (_forecast == null) {
          return const Text("Error getting weather");
        } else {
          return dailyBoxes(_forecast!);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget createAppBar(
    List<Location> locations, Location location, BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Column(children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 24.0,
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${locations[index].city.capitalizeFirstOfEach}, ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    TextSpan(
                                        text: locations[index]
                                            .country
                                            .capitalizeFirstOfEach,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ));
                }),
          ]);
        },
      );
    },
    child: Container(
        padding:
            const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
        margin: const EdgeInsets.only(
            top: 35, left: 15.0, bottom: 15.0, right: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(60)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '${location.city.capitalizeFirstOfEach}, ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  TextSpan(
                      text: location.country.capitalizeFirstOfEach,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Tap to change location',
            ),
          ],
        )),
  );
}

Widget weatherDetailsBox(Weather _weather) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
    margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]),
    child: Row(
      children: [
        Expanded(
            child: Column(
          children: [
            const Text(
              "Wind",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            ),
            Text(
              "${_weather.wind} km/h",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            const Text(
              "Humidity",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            ),
            Text(
              "${_weather.humidity.toInt()}%",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            const Text(
              "Pressure",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            ),
            Text(
              "${_weather.pressure} hPa",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            )
          ],
        ))
      ],
    ),
  );
}

Widget weatherBox(Weather _weather) {
  return Stack(children: [
    Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(15.0),
      height: 160.0,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  getWeatherIcon(_weather.icon),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        _weather.description.capitalizeFirstOfEach,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.black),
                      )),
                ])),
            Column(children: <Widget>[
              Text(
                "${_weather.temp.toInt()}°",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.black),
              ),
              Container(
                  margin: const EdgeInsets.all(0),
                  child: Text(
                    "Feels like ${_weather.feelsLike.toInt()}°",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black),
                  )),
            ])
          ],
        ))
  ]);
}

Image getWeatherIcon(String _icon) {
  String path = 'images/weather_icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 70,
    height: 70,
  );
}

Image getWeatherIconSmall(String _icon) {
  String path = 'images/weather_icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 40,
    height: 40,
  );
}

Widget hourlyBoxes(Forecast _forecast) {
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      height: 150.0,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
          scrollDirection: Axis.horizontal,
          itemCount: _forecast.hourly.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.only(
                    left: 10, top: 15, bottom: 15, right: 10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      )
                    ]),
                child: Column(children: [
                  Text(
                    "${_forecast.hourly[index].temp}°",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  getWeatherIcon(_forecast.hourly[index].icon),
                  Text(
                    getTimeFromTimestamp(_forecast.hourly[index].dt),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ]));
          }));
}

String getTimeFromTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = DateFormat('h:mm a');
  return formatter.format(date);
}

String getDateFromTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = DateFormat('E');
  return formatter.format(date);
}

Widget dailyBoxes(Forecast _forecast) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
      itemCount: _forecast.daily.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            margin: const EdgeInsets.all(5),
            child: Row(children: [
              Expanded(
                  child: Text(
                getDateFromTimestamp(_forecast.daily[index].dt),
                style: const TextStyle(fontSize: 14, color: Colors.black),
              )),
              Expanded(child: getWeatherIconSmall(_forecast.daily[index].icon)),
              Expanded(
                  child: Text(
                "${_forecast.daily[index].high.toInt()}/${_forecast.daily[index].low.toInt()}",
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              )),
            ]));
      });
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

Future getCurrentWeather(Location location) async {
  Weather? weather;
  String city = location.city;
  String apiKey = "24a19635acd2766d3e7f999be30b6ef4";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather;
}

Future getForecast(Location location) async {
  Forecast? forecast;
  String apiKey = "24a19635acd2766d3e7f999be30b6ef4";
  String lat = location.lat;
  String lon = location.lon;
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }

  return forecast;
}
