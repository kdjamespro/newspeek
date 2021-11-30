class GlobalCases {
  late int cases, todayCases, deaths, todayDeaths, recovered, todayRecovered;
  GlobalCases({
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
  });

  factory GlobalCases.fromJson(Map<String, dynamic> json) => GlobalCases(
        cases: json['cases'] as int,
        todayCases: json['todayCases'] as int,
        deaths: json['deaths'] as int,
        todayDeaths: json['todayDeaths'] as int,
        recovered: json['recovered'] as int,
        todayRecovered: json['todayRecovered'] as int,
      );
}
