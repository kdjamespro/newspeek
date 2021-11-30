import 'package:intl/intl.dart';

class CovidCases {
  late int cases, todayCases, deaths, todayDeaths, recovered, todayRecovered;
  late String updated;
  CovidCases(
      {required this.cases,
      required this.todayCases,
      required this.deaths,
      required this.todayDeaths,
      required this.recovered,
      required this.todayRecovered,
      required this.updated});

  factory CovidCases.fromJson(Map<String, dynamic> json) {
    int timeUpdated = json['updated'] as int;
    DateTime updatedDate = DateTime.fromMillisecondsSinceEpoch(timeUpdated);
    DateFormat df = DateFormat('MM-dd-yyyy HH:mm:ss');

    String updated = df.format(updatedDate);

    return CovidCases(
      cases: json['cases'] as int,
      todayCases: json['todayCases'] as int,
      deaths: json['deaths'] as int,
      todayDeaths: json['todayDeaths'] as int,
      recovered: json['recovered'] as int,
      todayRecovered: json['todayRecovered'] as int,
      updated: updated,
    );
  }
}
