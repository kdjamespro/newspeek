import 'package:news_peek/services/network.dart';
import 'package:news_peek/secrets.dart';

const String apiKey = newsAPIKey;
const websiteUrl = 'https://newsapi.org/v2';

class NewsModel {
  // get headlines based on country
  Future<dynamic> getCountryHeadlines(String countryCode) {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/top-headlines?country=$countryCode&apiKey=$apiKey');
    var headlines = getter.getData();
    return headlines;
  }

  // Get headlines based on a category
  Future<dynamic> getSourceHeadlines(String category) {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/top-headlines?category=$category&apiKey=$apiKey');
    var headlines = getter.getData();
    return headlines;
  }

  // Get headlines based on a keywords
  Future<dynamic> getNewsAbout(String keyword) {
    NetworkHelper getter =
        NetworkHelper('$websiteUrl/everything?q=$keyword&apiKey=$apiKey');
    var headlines = getter.getData();
    return headlines;
  }
}
