import 'package:flutter/material.dart';
import '../model/covid_cases.dart';
import '../utilities/fonts.dart';
import 'package:intl/intl.dart';

class CasesCard extends StatelessWidget {
  CasesCard({required this.top, required this.cases, this.chart, Key? key});

  final Widget top;
  final CovidCases cases;
  final Widget? chart;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,###');
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            top,
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                numbers(
                  cases: formatter.format(cases.cases),
                  title: 'Total Cases',
                  style: totalCasesFig,
                  newCases: formatter.format(cases.todayCases),
                  newStyle: totalCasesNewFig,
                ),
                Spacer(),
                numbers(
                  cases: formatter.format(cases.deaths),
                  title: 'Deaths',
                  style: deathsFig,
                  newCases: formatter.format(cases.todayDeaths),
                  newStyle: deathsNewFig,
                ),
                Spacer(),
                numbers(
                  cases: formatter.format(cases.recovered),
                  title: 'Recovered',
                  style: recoveredFig,
                  newCases: formatter.format(cases.todayRecovered),
                  newStyle: recoveredNewFig,
                ),
              ],
            ),
            chart ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget numbers({
    required String cases,
    required String title,
    required TextStyle style,
    required String newCases,
    required TextStyle newStyle,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: casesHeader,
        ),
        SizedBox(height: 5),
        Text(
          cases,
          style: style,
        ),
        Row(
          children: [
            Text(
              'New: ',
              style: newFig,
            ),
            Text(
              '+$newCases',
              style: newStyle,
            )
          ],
        )
      ],
    );
  }
}
