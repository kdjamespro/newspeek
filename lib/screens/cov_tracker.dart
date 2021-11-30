import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_peek/model/global_cases.dart';
import 'package:news_peek/services/covid.dart';
import '../screens/cases_card.dart';
import '../utilities/fonts.dart';

class Cov_Tracker extends StatefulWidget {
  const Cov_Tracker({Key? key}) : super(key: key);

  @override
  _Cov_TrackerState createState() => _Cov_TrackerState();
}

class _Cov_TrackerState extends State<Cov_Tracker> {
  late GlobalCases ww;
  late CovidModel generator;

  @override
  void initState() {
    generator = CovidModel();
    super.initState();
  }

  void setWorld() async {
    ww = await generator.getLatestWorldWide();
  }

  @override
  Widget build(BuildContext context) {
    setWorld();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
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
                    'Last Updated: ',
                    style: covidSubheading,
                  )
                ],
              ),
            ),
            CasesCard(
              top: Text(
                'Global Cases',
                style: casesTitle,
              ),
            ),
            CasesCard(
              top: Center(
                child: CountryListPick(
                  initialSelection: 'PH',
                  useUiOverlay: true,
                  useSafeArea: false,
                  theme: CountryTheme(
                    isShowFlag: true,
                    isShowTitle: true,
                    isShowCode: false,
                    isDownIcon: true,
                    showEnglishName: true,
                  ),
                  onChanged: (code) {
                    print(code!.name);
                    print(code.code);
                    print(code.dialCode);
                    print(code.flagUri);
                    print(ww.todayRecovered);
                    print(ww.todayDeaths);
                  },
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
