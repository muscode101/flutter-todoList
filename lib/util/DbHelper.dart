
import 'dart:core';
import 'dart:io';

import 'package:fluttertodolist/model/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  static final DbHelper _dbHelper = DbHelper.internal();
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  DbHelper.internal();

  factory DbHelper() => _dbHelper;

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todo.db";
    var todoDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDb;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY,"
        "$colTitle TEXT,"
        "$colDescription TEXT,"
        "$colPriority INTEGER,"
        "$colDate TEXT)");
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblTodo ORDER BY $colPriority ASC");
    return result;
  }

  Future<int> getCount() async{
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT count (*) $tblTodo")
    );
    return result;
  }

  Future<int> updateTodo(Todo todo) async{
    var db = await this.db;
    var result = await db.update(tblTodo, todo.toMap());
    return result;
  }

  Future<int> deleteTodo(int id)async{
    var db = await this.db;
    var result = await db.rawDelete("DELETE FROM  $tblTodo WHERE $colId =$id");
    return result;
  }
}
