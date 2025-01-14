import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveUserData(value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return await sharedPreferences.setInt("user_id", value);
}

Future getUserData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt("user_id");
}
