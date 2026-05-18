import 'package:shared_preferences/shared_preferences.dart';

class KSharedPreferencesKeys {
  static String accsesstoken = "accsesstoken";
  static String refreshtoken = "refreshtoken";
  static String username = "username";
  static String email = "email";
}

class SharedPreferencesHelper {
  static late SharedPreferences pref;
  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static String? getString(String key) {
    return pref.getString(key);
  }

  static Future<void> removeKey(String key) async {
    await pref.remove(key);
  }
}
