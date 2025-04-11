import 'package:flutter/material.dart';
import 'package:simple_page/news_app/models/news.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'news_db.db';
  static const String _tableName = 'news';

  // Getter to retrieve the database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    // Ensure that plugin services are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Get the default databases location
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    // Open the database, creating it if it doesn't exist
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version ) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source TEXT,
            author TEXT,
            title TEXT,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  // Insert news data into the database
  static Future<void> insertNews(List<Article> articles) async {
    final db = await database;
    final batch = db.batch();
    for (var article in articles) {
      batch.insert(
        _tableName,
        article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Fetch news from the database
  static Future<List<Article>> fetchNewsFromDb() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => Article.fromMap(maps[i]));
    
  }
}
