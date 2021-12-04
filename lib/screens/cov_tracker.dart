import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/model/covid_cases.dart';
import 'package:news_peek/services/covid.dart';
import '../screens/cases_card.dart';
import '../utilities/fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class Cov_Tracker extends StatefulWidget {
  const Cov_Tracker({Key? key}) : super(key: key);

  @override
  _Cov_TrackerState createState() => _Cov_TrackerState();
}

class _Cov_TrackerState extends State<Cov_Tracker>
    with AutomaticKeepAliveClientMixin {
  late Future<CovidCases> ww;
  late Future<CovidCases> country;
  late CovidModel generator;

  String countryCode = 'PH';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    generator = CovidModel();
    ww = generator.getLatestWorldWide();
    country = generator.getLatestCountry(countryCode);
    super.initState();
  }

  void updateCountry(String code) async {
    setState(() {
      country = generator.getLatestCountry(code);
    });
  }

  String updated = '';

  void updateDate(String status) {
    setState(() {
      updated = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: ww,
              builder:
                  (BuildContext context, AsyncSnapshot<CovidCases> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    'No data',
                    textAlign: TextAlign.center,
                  ));
                } else {
                  CovidCases world = snapshot.data ??
                      CovidCases(
                          cases: 0,
                          todayCases: 0,
                          deaths: 0,
                          todayDeaths: 0,
                          recovered: 0,
                          todayRecovered: 0,
                          updated: 'No updates');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 14, 5, 5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15),
                          padding: const EdgeInsets.all(15.0),
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Color(0XFFdd1f8a),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                'COVID-19 Cases Live Updates',
                                style: covidTitle,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Last Update: ${world.updated}',
                                style: covidSubheading,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CasesCard(
                        top: Text(
                          'Global Cases',
                          style: casesTitle,
                        ),
                        cases: world,
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: country,
              builder:
                  (BuildContext context, AsyncSnapshot<CovidCases> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return countryCard(
                      CovidCases(
                          cases: 0,
                          todayCases: 0,
                          deaths: 0,
                          todayDeaths: 0,
                          recovered: 0,
                          todayRecovered: 0,
                          updated: 'No updates'),
                      null);
                } else {
                  CovidCases country = snapshot.data ??
                      CovidCases(
                          cases: 0,
                          todayCases: 0,
                          deaths: 0,
                          todayDeaths: 0,
                          recovered: 0,
                          todayRecovered: 0,
                          updated: 'No updates');
                  Map<String, double> data = {
                    "deaths": country.deaths.toDouble(),
                    "cases": country.cases.toDouble(),
                    "recovered": country.recovered.toDouble(),
                  };
                  return countryCard(
                      country,
                      Container(
                        margin: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: PieChart(
                          dataMap: data,
                          chartRadius: MediaQuery.of(context).size.width / 4,
                          chartType: ChartType.ring,
                          chartLegendSpacing: 60.0,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValuesInPercentage: true,
                            showChartValues: false,
                            showChartValuesOutside: true,
                          ),
                        ),
                      ));
                }
              },
            ),
          ],
        )),
      ),
    );
  }

  Widget countryCard(CovidCases country, Widget? chart) {
    return CasesCard(
      top: Center(
        child: CountryListPick(
          initialSelection: countryCode,
          useUiOverlay: true,
          useSafeArea: false,
          theme: CountryTheme(
            isShowFlag: true,
            isShowTitle: true,
            isShowCode: false,
            isDownIcon: true,
            showEnglishName: true,
          ),
          onChanged: (CountryCode? code) {
            String? ch = code!.code;
            countryCode = ch!;
            updateCountry(countryCode);
          },
        ),
      ),
      cases: country,
      chart: chart,
    );
  }

  // List<PieChartSectionData> pieSections(CovidCases country) {
  //   return List.generate(3, (i) {
  //     final fontSize = 10.0;
  //     final radius = 80.0;
  //     final total = country.cases.toDouble();
  //     final deaths = country.deaths.toDouble();
  //     final recovered = country.recovered.toDouble();
  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color: const Color(0xff0293ee),
  //           value: (total - deaths - recovered) / total,
  //           radius: radius,
  //           title: 'cases',
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: const Color(0xffffffff),
  //           ),
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color: const Color(0xfff8b250),
  //           value: deaths / total,
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: const Color(0xffffffff)),
  //         );
  //       case 2:
  //         return PieChartSectionData(
  //           color: const Color(0xff845bef),
  //           value: recovered / total,
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: const Color(0xffffffff)),
  //         );
  //       default:
  //         throw Error();
  //     }
  //   });
  // }
}

// return countryCard(
//     country,
//     );
//
// PieChart(PieChartData(
// sections: pieSections(country),
// centerSpaceRadius: 0,
// sectionsSpace: 1,
// ));
