import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:news_peek/model/article.dart';
import 'package:path_provider/path_provider.dart';

class Bookmark {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return '$directory'.replaceAll('\'', '').split(' ')[1];
  }

  void saveBookmark(Article article) async {
    String filePath = '${await _localPath}/bookmark.json';
    final bool exists = await File(filePath).exists();
    File file = File(filePath);
    if (!exists) {
      List<Article> app = [article];
      await file.writeAsString(jsonEncode(app));
      bool exist = await File(filePath).exists();
    } else {
      String json = await file.readAsString();
      print(json);
      List<dynamic> body = await jsonDecode(json);
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      articles.add(article);
      await file.writeAsString(jsonEncode(articles));
      print(articles.length);
    }
  }

  void deleteBookmark(Article article) async {
    String filePath = '${await _localPath}/bookmark.json';
    File file = File(filePath);
    String json = await file.readAsString();
    List<dynamic> body = await jsonDecode(json);
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    try {
      for (int i = 0; i < articles.length; i++) {
        if (articles[i].url == article.url) {
          articles.removeAt(i);
          break;
        }
      }
    } catch (e) {
      print(e);
    }
    await file.writeAsString(jsonEncode(articles));
    print(articles.length);
  }

  Future<File> writeFile(File file, var bookmark) async {
    return await file.writeAsString(jsonEncode(bookmark));
  }
}
