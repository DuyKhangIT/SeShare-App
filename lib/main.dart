import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/routes/app_routes.dart';


import 'config/theme_service.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.inputPasswordRegisterScreen,
      getPages: AppRoutes.pages,
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
