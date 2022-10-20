import 'package:aplikasi_notes/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String tableName = 'tableJudul';
  final String columnId = 'id';
  final String columnJudul = 'judul';
  final String columnSubjudul = 'subjudul';
  final String columnTanggal = 'tanggal';
  final String columnIsi = 'isi';

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnJudul TEXT,"
        "$columnSubjudul TEXT,"
        "$columnTanggal TEXT,"
        "$columnIsi TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveNotes(Notes notes) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, notes.toMap());
  }

  Future<List?> getAllNotes() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnJudul,
      columnSubjudul,
      columnTanggal,
      columnIsi
    ]);
    return result.toList();
  }

  Future<int?> updateNotes(Notes notes) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, notes.toMap(),
        where: '$columnId = ?', whereArgs: [notes.id]);
  }

  Future<int?> deleteNotes(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
