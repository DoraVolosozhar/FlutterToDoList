// Importing required packages and modules.
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/tables/tbl_task.dart';

/// This class provides operations to interact with the SQLite database.
class DBProvider {
  /// Factory constructor to return the singleton instance of DBProvider.
  factory DBProvider() {
    return db;
  }

  /// Private constructor to prevent direct instantiation.
  DBProvider._privateConstructor();

  /// Defining the version  for the database.
  final int databaseVersion = 4;

  /// Defining the name for the database.
  final String databaseName = 'ToDoList.db';

  /// A Database instance to interact with the SQLite database.
  static late Database database;

  /// Static instance of DBProvider for singleton access.
  static final DBProvider db = DBProvider._privateConstructor();

  /// An instance of the Task table.
  Task task = Task();

  /// Method to initialize the database.
  Future<Database> initDatabase() async {
    // Ensuring the widget binding is initialized.
    WidgetsFlutterBinding.ensureInitialized();

    ///  Logging the database initialization.
    print('Database initialization');

    /// Determining the path for the database file.
    final databasePath = join(await getDatabasesPath(), databaseName);

    database = await openDatabase(databasePath, onCreate: _onCreate, version: databaseVersion);

    return database;
  }

  /// Method to create tables in the database.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE Task (
        ID INTEGER PRIMARY KEY AUTOINCREMENT, 
        TITLE STRING,
        DESCRIPTION STRING,
        CREATIONDATE STRING,
        DEADLINE STRING,
        PRIORITY STRING,
        CREATORID INTEGER
        )
        ''');
  }

  /// Method to query the database.
  Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    final db = DBProvider.database;

    final List<Map<String, dynamic>> rows =
        await db.query(table, columns: columns, where: where, whereArgs: whereArgs, orderBy: orderBy);
    return Future.value(rows);
  }

  /// Method to run raw SQL queries on the database.
  Future<List<Map<String, dynamic>>> rawQuery(String sql, List<dynamic> arguments) async {
    final db = DBProvider.database;
    final List<Map<String, dynamic>> rows = await db.rawQuery(sql, arguments);
    return Future.value(rows);
  }

  /// Method to insert values into a table.
  Future<int> insert(String table, Map<String, dynamic> values) async {
    final Database database = DBProvider.database;
    final int id = await database.insert(table, values, conflictAlgorithm: ConflictAlgorithm.replace);
    return Future.value(id);
  }

  /// Method to update values in a table.
  Future<int> update(String table, Map<String, dynamic> values, String where, List<dynamic> whereArgs) async {
    final db = DBProvider.database;
    final int count = await db.update(table, values, where: where, whereArgs: whereArgs);
    return Future.value(count);
  }

  /// Method to delete rows from a table.
  Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = DBProvider.database;
    final int row = await db.delete(table, where: where, whereArgs: whereArgs);
    return Future.value(row);
  }
}
