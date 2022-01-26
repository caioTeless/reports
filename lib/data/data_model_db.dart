import 'package:path/path.dart';
import 'package:reports/model/data_model.dart';
import 'package:sqflite/sqflite.dart';

class DataModelDB {
  static String tableName = 'reports_table';
  static String databaseName = 'reports.db';
  static String queryCreateSql =
      'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, name TEXT, value REAL)';

  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), databaseName);
    return openDatabase(path, onCreate: (db, version) {
      db.execute(queryCreateSql);
    }, version: 1);
  }

  Future insert(DataModel dataModel) async {
    Database db;
    db = await _getDatabase();
    db.insert(
      tableName,
      dataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future update(DataModel dataModel) async {
    Database db;
    db = await _getDatabase();
    db.update(
      tableName,
      dataModel.toMap(),
      where: 'id = ?',
      whereArgs: [dataModel.id],
    );
  }

  Future delete(DataModel dataModel) async {
    Database db;
    db = await _getDatabase();
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [dataModel.id],
    );
  }

  Future<DataModel> readById(int id) async {
    Database db;
    db = await _getDatabase();
    final data = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return DataModel.fromMap(data[0]);
  }

  Future<List<DataModel>> readAll() async {
    Database db;
    db = await _getDatabase();
    final data = await db.query(tableName);
    return List.generate(
      data.length,
      (index) => DataModel.fromMap(
        data[index],
      ),
    );
  }

  Future deleteAll() async{
    Database db;
    db = await _getDatabase();
    db.rawDelete('DELETE FROM $tableName');
  }
}
