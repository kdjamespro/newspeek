import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'article.dart';

class BookmarkDb {
  static final BookmarkDb instance = BookmarkDb._init();

  static Database? _database;

  BookmarkDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bookmark.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const stringType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $articles (
    ${ArticleFields.author} $stringType,
    ${ArticleFields.title} $stringType,
    ${ArticleFields.description} $stringType,
    ${ArticleFields.url} $stringType,
    ${ArticleFields.urlToImage} $stringType,
    ${ArticleFields.publishedAt} $stringType,
    ${ArticleFields.content} $stringType
    )''');
  }

  Future save(Article article) async {
    final db = await instance.database;
    if (article.title.contains('\'') || article.title.contains('\"')) {
      article.title = _processTitle(article.title);
    }
    await db.insert(articles, article.toJson());
  }

  Future<List<Article>> getBookmarks() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT * FROM $articles');

    return result.map((json) => Article.fromJson(json)).toList();
  }

  Future<bool> doesExist(String title) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        '''SELECT EXISTS (SELECT * FROM $articles WHERE ${ArticleFields.title}=\'${_processTitle(title)}\')''');

    int? exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }

  Future delete(String title) async {
    final db = await instance.database;
    await db.delete(
      articles,
      where: '${ArticleFields.title} = ?',
      whereArgs: [title],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  String _processTitle(String title) {
    String newTitle = title.replaceAll('\"', '\"\"');
    newTitle = newTitle.replaceAll('\'', '\'\'');
    return newTitle;
  }
}
