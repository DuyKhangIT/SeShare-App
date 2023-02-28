import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../util/global.dart';

class ThemeService {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.blueGrey.shade300,
      appBarTheme: const AppBarTheme(
        color: Colors.white
      ),
      dividerColor: Global.mobileBackgroundColor);
  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(),
      dividerColor: Colors.white54);

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSaveDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSaveDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSaveDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSaveDarkMode());
  }
}
