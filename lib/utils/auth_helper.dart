import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:diary/utils/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveUserData(value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.setInt("user_id", value);
}

Future<int?> getUserData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt("user_id");
}

Future<bool> logout() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.clear();
}

String encryptPassword(password) {
  return sha256.convert(utf8.encode(password)).toString();
}

Future<void> registerUser(String name, String email, String password) async {
  final db = await DatabaseHelper().database;
  password = encryptPassword(password);
  await db.insert(
    'users',
    {'name': name, 'email': email, 'password': password},
  );
}

Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  final db = await DatabaseHelper().database;
  password = encryptPassword(password);
  List<Map<String, dynamic>> users = await db.query(
    'users',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );
  if (users.isNotEmpty) {
    int uId = users.first['id'] as int;
    saveUserData(uId);
  }
  return users.isNotEmpty ? users.first : null;
}

Future<String?> getNameById(int uid) async {
  final db = await DatabaseHelper().database;
  List<Map<String, dynamic>> result = await db.query(
    'users',
    columns: ['name'],
    where: 'id = ?',
    whereArgs: [uid],
  );

  if (result.isNotEmpty) {
    return result.first['name'] as String;
  }
  return null;
}


