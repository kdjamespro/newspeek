class Article {
  late final Source source;
  late final String author,
      title,
      description,
      url,
      imageUrl,
      publishedAt,
      content;

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
      source: Source.fromJson(json['source']),
      author: author,
      title: title,
      description: description,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      content: content,
    );
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
}
