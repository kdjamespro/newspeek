import 'package:flutter/cupertino.dart';

const String articles = 'articles';

class ArticleFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String author = 'author';
  static final String title = 'title';
  static final String description = 'description';
  static final String url = 'url';
  static final String urlToImage = 'urlToImage';
  static final String publishedAt = 'publishedAt';
  static final String content = 'content';
}

class Article {
  late final Source source;
  late String author, title, description, url, imageUrl, publishedAt, content;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.imageUrl,
      required this.publishedAt,
      required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    Source source = json.containsKey('source')
        ? Source.fromJson(json['source'])
        : Source(name: 'No Name', id: 'No id');
    String author = json['author'] ?? 'Unknown Author';
    String title = json['title'].trim() ?? 'No Title';
    String description = json['description'] ?? 'No Description';
    String url = json['url'] ?? 'No URL';
    String imageUrl = json['urlToImage'] ?? 'No Image';
    String publishedAt = json['publishedAt'] ?? 'No Time';
    if (publishedAt != 'No Time') {
      publishedAt = publishedAt.replaceFirst('T', ' ');
      publishedAt = publishedAt.substring(0, publishedAt.length - 1);
    }
    String content = json['content'] ?? 'No Content';

    return Article(
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      content: content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class Source {
  Source({required this.name, required this.id});

  String id, name;

  factory Source.fromJson(Map<String, dynamic> source) {
    String id = source['id'] ?? 'No ID';
    String name = source['name'] ?? 'No Name';
    return Source(id: id, name: name);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
