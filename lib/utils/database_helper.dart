import 'dart:async';
import 'package:hangman/model/model.dart';
import 'package:hangman/model/theWords.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {

  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {

    if (_db != null) { return; }

    try {
      String _path = await getDatabasesPath() + 'example14';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);

      List<String> _sampleWords = ['hello','goodbye','joked','overjoyful','discussion','species','occasionally','neighborhood','simplest','explanation'];

      for(int i = 0; i < _sampleWords.length;i++) {
        Words item = Words(
          word: _sampleWords[i],
        );
        await DB.insert(Words.table, item);
      }
    }
    catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async =>
    await db.execute(
        'CREATE TABLE words (id INTEGER PRIMARY KEY NOT NULL, word STRING UNIQUE)');

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table, orderBy: 'word');

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}