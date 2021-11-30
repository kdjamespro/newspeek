import '../model/global_cases.dart';
import 'package:news_peek/services/network.dart';
import 'dart:convert';

const url = 'https://disease.sh/v3/covid-19';

class CovidModel {
  // Get Covid Cases by Country
  Future<GlobalCases> getLatestWorldWide() async {
    NetworkHelper getter = NetworkHelper('$url/all');
    var report = await getter.getData();
    Map<String, dynamic> data = await jsonDecode(report);
    print(data);
    GlobalCases ww = GlobalCases.fromJson(data);
    return ww;
  }
}
