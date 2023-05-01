import 'package:shared_preferences/shared_preferences.dart';

enum SharedData {
  TOKEN,
  USERID,
  PHONE
}
class ConfigSharedPreferences {
  /// khởi tạo shared preference and reload
  Future<SharedPreferences> getSharedPreference() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    await ref.reload();
    return ref;
  }
  /// lưu giá trị
  void setStringValue(String key, String value) async {
    SharedPreferences ref = await getSharedPreference();
    ref.setString(key, value);
  }
  /// lấy giá trị
  Future<String> getStringValue(String key, {String? defaultValue}) async {
    SharedPreferences ref = await getSharedPreference();
    final String? returnValue = ref.getString(key);
    if (returnValue == null) return defaultValue ?? "";
    return returnValue;
  }


}