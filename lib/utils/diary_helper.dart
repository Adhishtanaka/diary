import 'package:diary/utils/db_helper.dart';

Future<void> addDiaryEntry(int userId, String title, String description, DateTime day) async {
  final db = await DatabaseHelper().database;
  String formattedDate = DateTime(day.year, day.month, day.day).toIso8601String();
  await db.insert(
    'diary',
    {
      'user_id': userId,
      'title': title,
      'description': description,
      'date_time': formattedDate
    },
  );
}

Future<void> updateDiaryEntry(int userId, String title, String description, DateTime day) async {
  final db = await DatabaseHelper().database;
  String formattedDate = DateTime(day.year, day.month, day.day).toIso8601String();
  await db.update(
    'diary',
    {
      'title': title,
      'description': description,
      'date_time': formattedDate,
    },
    where: 'user_id = ? AND date_time LIKE ?',
    whereArgs: [userId, formattedDate],
  );
}

Future<List<DateTime>> getMarkedDates(int userId) async {
  final db = await DatabaseHelper().database;
  final List<Map<String, dynamic>> diaries =
  await db.query('diary', where: 'user_id = ?', whereArgs: [userId]);
  return diaries
      .map((entry) => DateTime.parse(entry['date_time']))
      .toList();
}

Future<Map<String, dynamic>?> getUserDiary(int userId, DateTime day) async {
  final db = await DatabaseHelper().database;
  String formattedDate = DateTime(day.year, day.month, day.day).toIso8601String();
  final List<Map<String, dynamic>> results = await db.query(
    'diary',
    where: 'user_id = ? AND date_time = ?',
    whereArgs: [userId, formattedDate],
    limit: 1,
  );
  return results.isNotEmpty ? results.first : null;
}

Future<void> deleteDiaryEntry(int userId, DateTime day) async {
  final db = await DatabaseHelper().database;
  String formattedDate = DateTime(day.year, day.month, day.day).toIso8601String();
  await db.delete('diary', where: 'user_id = ? AND date_time = ?', whereArgs: [userId, formattedDate]);
}
