import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:streaming_app/data/models/saved_anime_model.dart';

class AnimeDatabase {
  static final AnimeDatabase instance = AnimeDatabase._init();
  static Database? _database;

  AnimeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anime.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE saved_anime ADD COLUMN episodes INTEGER;');
      await db.execute('ALTER TABLE saved_anime ADD COLUMN score TEXT;');
      await db.execute(
        'ALTER TABLE saved_anime ADD COLUMN lastReleaseDate TEXT;',
      );
      await db.execute('ALTER TABLE saved_anime ADD COLUMN otakudesuUrl TEXT;');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE saved_anime (
      animeId TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      poster TEXT NOT NULL,
      episodes INTEGER,
      score TEXT,
      lastReleaseDate TEXT,
      href TEXT,
      otakudesuUrl TEXT,
      createdAt INTEGER
    )
  ''');
  }

  Future<void> saveAnime(SavedAnimeModel anime) async {
    final db = await database;

    await db.insert('saved_anime', {
      ...anime.toJson(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SavedAnimeModel>> getSavedAnime() async {
    final db = await database;

    final result = await db.query('saved_anime', orderBy: 'createdAt DESC');

    return result.map((e) => SavedAnimeModel.fromJson(e)).toList();
  }

  Future<bool> isSaved(String animeId) async {
    final db = await database;

    final result = await db.query(
      'saved_anime',
      where: 'animeId = ?',
      whereArgs: [animeId],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<void> removeSavedAnime(String animeId) async {
    final db = await database;

    await db.delete('saved_anime', where: 'animeId = ?', whereArgs: [animeId]);
  }
}
