import 'dart:convert';

import 'package:news_peek/services/network.dart';
import 'package:news_peek/secrets.dart';
import 'package:news_peek/model/article.dart';

const String apiKey = newsAPIKey;
const websiteUrl = 'https://newsapi.org/v2';

class NewsModel {
  Future<List<Article>> getCountryHeadlines(String countryCode) async {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/top-headlines?country=$countryCode&apiKey=$apiKey');
    String responseBody = await getter.getData();
    Map<String, dynamic> data = await jsonDecode(responseBody);

    List<dynamic> body = data['articles'];

    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
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
