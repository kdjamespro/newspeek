import '../model/covid_cases.dart';
import 'package:news_peek/services/network.dart';
import 'dart:convert';

const url = 'https://disease.sh/v3/covid-19';

class CovidModel {
  // Get Covid Cases by Country
  Future<CovidCases> getLatestWorldWide() async {
    NetworkHelper getter = NetworkHelper('$url/all');
    var report = await getter.getData();
    Map<String, dynamic> data = await jsonDecode(report);
    CovidCases ww = CovidCases.fromJson(data);
    return ww;
  }

  Future<CovidCases> getLatestCountry(String country) async {
    NetworkHelper getter = NetworkHelper('$url/countries/$country?strict=true');
    var report = await getter.getData();
    Map<String, dynamic> data = await jsonDecode(report);
    CovidCases ww = CovidCases.fromJson(data);
    return ww;
  }
}
