import 'package:sqflite/sqflite.dart' as sqf;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sqf.Database> database() async {
    final dbPath = await sqf.getDatabasesPath();
    return sqf.openDatabase(path.join(dbPath, 'movies.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE movies(id INTEGER, original_language TEXT, original_title TEXT, overview TEXT, popularity REAL, poster_path TEXT, release_date TEXT, title TEXT, vote_count INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert('movies', data, conflictAlgorithm: sqf.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await DBHelper.database();
    return db.query('movies');
  }

  static Future<void> delete(int id) async {
    final db = await DBHelper.database();
    return await db.delete(
      'movies',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
