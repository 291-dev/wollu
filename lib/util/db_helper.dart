import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../entity/User.dart';

class DBHelper {
  Future _openDb() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'wollu.db');

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) => {},
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) => {},
    );

    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS times (
      id INTEGER NOT NULL,
      alltime INTEGER NOT NULL,
      no INTEGER NOT NULL,
      coffee INTEGER NOT NULL,
      toilet INTEGER NOT NULL,
      wind INTEGER NOT NULL,
      shopping INTEGER NOT NULL,
      smoking INTEGER NOT NULL,
      something INTEGER NOT NULL,
      turnover INTEGER NOT NULL
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user (
      id INTEGER NOT NULL,
      nickname TEXT NOT NULL,
      salary INTEGER NOT NULL,
      week INTEGER NOT NULL,
      day INTEGER NOT NULL,
      job TEXT NOT NULL,
      annual TEXT NOT NULL,
      sex INTEGER NOT NULL,
      age TEXT NOT NULL
    )
  ''');
  }

  Future add(int id, String nickname, int salary, int week_work, int day_work, String job, String annual, int sex, String age) async {
    final db = await _openDb();
    var result = await db.insert(
      'user',  // table name
      {
        'id': id,
        'nickname': nickname,
        'salary': salary,
        'week': week_work,
        'day': day_work,
        'job': job,
        'annual': annual,
        'sex': sex,
        'age': age,
      },  // new post row data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future addWollu(int id, int all, int no, int coffee, int toilet, int wind, int shopping, int smoking, int something, int turnover,) async {
    final db = await _openDb();
    var result = await db.insert(
      'times',  // table name
      {
        'id': id,
        'alltime': all,
        'no': no,
        'coffee': coffee,
        'toilet': toilet,
        'wind': wind,
        'shopping': shopping,
        'smoking': smoking,
        'something': something,
        'turnover': turnover
      },  // new post row data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future updateWollu(int dbId, int id, int all, int no, int coffee, int toilet, int wind, int shopping, int smoking, int something, int turnover,) async {
    final db = await _openDb();
    var result = await db.update(
      'times',  // table name
      {
        'id': id,
        'alltime': all,
        'no': no,
        'coffee': coffee,
        'toilet': toilet,
        'wind': wind,
        'shopping': shopping,
        'smoking': smoking,
        'something': something,
        'turnover': turnover
      },  // new post row data
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [dbId]
    );
    return result;
  }

  Future<void> updateUser(int id, String nickname, int salary, int week_work, int day_work, String job, String annual, int sex, String age) async {
    final db = await _openDb();

    await db.update(
      "user",
      {
        'id': id,
        'nickname': nickname,
        'salary': salary,
        'week': week_work,
        'day': day_work,
        'job': job,
        'annual': annual,
        'sex': sex,
        'age': age,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<User>> get() async {
    try {
      final db = await _openDb();
      final List<Map<String, dynamic>> maps = await db.query(
          'user'
      );
      return List.generate(maps.length, (index) {
        final user = User(
            id: maps[index]['id'],
            nickname: maps[index]['nickname'],
            salary: maps[index]['salary'],
            week_work: maps[index]['week'],
            day_work: maps[index]['day'],
            job: maps[index]['job'],
            annual: maps[index]['annual'],
            sex: maps[index]['sex'],
            age: maps[index]['age']
        );
        return user;
      });
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<int>> getWollu(int id) async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query(
        'times'
    );
    try {
      final lastMap = maps.last;
      return [
        lastMap['id'],
        lastMap['alltime'],
        lastMap['no'],
        lastMap['coffee'],
        lastMap['toilet'],
        lastMap['wind'],
        lastMap['shopping'],
        lastMap['smoking'],
        lastMap['something'],
        lastMap['turnover'],
      ];
    } catch (e) {
      return [

      ];
    }

  }

  Future<void> delete() async {
    final db = await _openDb();
    await db.delete(
      'times'
    );
  }
}