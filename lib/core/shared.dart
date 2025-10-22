import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setString({required String key, required String value}) {
    return sharedPreferences!.setString(key, value);
  }

  static getString({required String key}) {
    return sharedPreferences!.getString(key);
  }
  static Future<void> clearAll() async {
    await sharedPreferences?.clear();
  }
}
