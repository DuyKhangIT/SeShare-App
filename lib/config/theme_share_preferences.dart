import 'package:shared_preferences/shared_preferences.dart';

class ThemSharedPreferences {
  static const PREF_KEY = 'preferences';

  setTheme(bool value) async {
    SharedPreferences sharePreferences = await SharedPreferences.getInstance();
    sharePreferences.setBool(PREF_KEY,value);

  }

  getTheme()async{
    SharedPreferences sharePreferences = await SharedPreferences.getInstance();
    return sharePreferences.getBool(PREF_KEY) ?? false;
  }
}