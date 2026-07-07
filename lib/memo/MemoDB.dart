import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'memo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE TBL_MEMO (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            date TEXT
          )
        ''');
      },
    );

  }
  static Future<void> insertMemo(String title, String content, String date) async{
    final db = await getDatabase();
    await db.insert("TBL_MEMO",
        {'title' : title, 'content' : content, 'date' : date}
    ); // insert
  }

  static Future<List<Map<String, dynamic>>> selectMemoList() async{
    final db = await getDatabase();
    return await db.query("TBL_MEMO"); // 목록을 가져오는 함수
  }

  static Future<void> deleteMemo(int id) async{
    final db = await getDatabase();
    await db.delete("TBL_MEMO", where: "id = ?", whereArgs: [id] );
  }

  static Future<void> updateMemo(String title, String content, int id) async{
    final db = await getDatabase();
    await db.update("TBL_MEMO", {'title' : title, 'content' : content}, where: "id = ?",whereArgs: [id],);
  }

  static Future<Map<String, dynamic>> selectMemoById(int id) async {
    final db = await getDatabase();
    var result = await db.query("TBL_MEMO", where: "id = ?", whereArgs: [id]);
    return result.first;
  }
// 함수 작성
// date 넣을 때 'DATE': DateTime.now().toIso8601String(), 이런식
// ex )
// await db.insert(
//   'TBL_MEMO',
//   {
//     'title': title,
//     'content': content,
//     'date': DateTime.now().toIso8601String(),
//   },
// );
// 2025-12-16

// 꺼내서 쓸때는
// DateTime date = DateTime.parse(map['DATE']);
// 이런식으로 변경

}