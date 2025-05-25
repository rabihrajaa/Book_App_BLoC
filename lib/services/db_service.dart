import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'books.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE favorites(
          id TEXT PRIMARY KEY,
          title TEXT,
          author TEXT,
          thumbnail TEXT
        )
      ''');
    });
  }

  static Future<void> insertItem(Book book) async {
    final db = await database;
    await db.insert('favorites', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

 static Future<List<Book>> getItems() async {
  final db = await database;
  final List<Map<String, Object?>> maps = await db.query('favorites');
  return List.generate(maps.length, (i) {
    final map = maps[i];
    return Book(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      author: map['author'] as String? ?? '',
      thumbnail: map['thumbnail'] as String? ?? '',
    );
  });
}


  static Future<void> deleteItem(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<bool> isSaved(String id) async {
    final db = await database;
    final result = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
