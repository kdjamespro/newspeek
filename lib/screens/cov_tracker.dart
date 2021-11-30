import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/model/covid_cases.dart';
import 'package:news_peek/services/covid.dart';
import '../screens/cases_card.dart';
import '../utilities/fonts.dart';

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
                  return const Center(child: Text('No data'));
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
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15),
                        padding: const EdgeInsets.all(15.0),
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Color(0XFFdd1f8a),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'COVID-19 Cases Live Updates',
                              style: covidTitle,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Last Update: ${world.updated}',
                              style: covidSubheading,
                            ),
                          ],
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
                  return countryCard(CovidCases(
                      cases: 0,
                      todayCases: 0,
                      deaths: 0,
                      todayDeaths: 0,
                      recovered: 0,
                      todayRecovered: 0,
                      updated: 'No updates'));
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
                  return countryCard(country);
                }
              },
            )
          ],
        )),
      ),
    );
  }

  Widget countryCard(CovidCases country) {
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
    );
  }
}
