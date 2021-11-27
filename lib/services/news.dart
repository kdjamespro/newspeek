import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_peek/screens/profile_screen.dart';
import 'package:news_peek/services/network.dart';
import 'package:news_peek/secrets.dart';
import 'package:news_peek/model/article.dart';

const String apiKey = newsAPIKey;
const websiteUrl = 'https://newsapi.org/v2';

class NewsModel {
  NewsModel([language]) {
    this.language = language ?? 'en';
  }

  late final String language;

  // Get Articles based on country
  Future<List<Article>> getCountryHeadlines(String countryCode) async {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/top-headlines?country=$countryCode&?language=$language&apiKey=$apiKey');
    return await getArticles(getter);
  }

  // Get Articles based on a category
  Future<List<Article>> getCategoryHeadlines(String category) async {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/top-headlines?category=$category&language=$language&apiKey=$apiKey');
    return getArticles(getter);
  }

  // Get Articles based on a keywords
  Future<List<Article>> getNewsAbout(String keyword) async {
    NetworkHelper getter = NetworkHelper(
        '$websiteUrl/everything?q=$keyword&language=$language&apiKey=$apiKey');
    return getArticles(getter);
  }

  Future<List<Article>> getArticles(NetworkHelper getter) async {
    String responseBody = await getter.getData();
    Map<String, dynamic> data = await jsonDecode(responseBody);

    List<dynamic> body = data['articles'];

    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

    return articles;
  }
}
