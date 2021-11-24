import 'package:news_peek/services/network.dart';

const url = 'covid-19-data.p.rapidapi.com';
const apiKey = 'b2d91ac521msh2d446e82eb70713p1e765bjsnf9c422874477';

class CovidModel {
  Future<dynamic> getLatestByCountry(String country) {
    NetworkHelper getter =
        NetworkHelper('$url/country?name=$country&apiKey=$apiKey');
    var report = getter.getData();
    return report;
  }
}
