import 'package:flutter/material.dart';
import '../utilities/fonts.dart';
import 'package:intl/intl.dart';

class CasesCard extends StatelessWidget {
  CasesCard({required this.top, Key? key});

  Widget top;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###,000');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            top,
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                numbers(
                  cases: formatter.format(1254464),
                  title: 'Total Cases',
                  style: totalCasesFig,
                  newCases: formatter.format(54821),
                  newStyle: totalCasesNewFig,
                ),
                numbers(
                  cases: formatter.format(1000000),
                  title: 'Deaths',
                  style: deathsFig,
                  newCases: formatter.format(4821),
                  newStyle: deathsNewFig,
                ),
                numbers(
                  cases: formatter.format(9999999),
                  title: 'Recovered',
                  style: recoveredFig,
                  newCases: formatter.format(123821),
                  newStyle: recoveredNewFig,
                ),
              ],
            ),
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
