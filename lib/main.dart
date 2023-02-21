import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/responsive/mobile_screen.dart';
import 'package:instagram_app/responsive/responsive_layout.dart';
import 'package:instagram_app/responsive/web_screen.dart';
import 'package:instagram_app/util/global.dart';
import 'package:instagram_app/views/home.dart';
import 'package:instagram_app/views/input_otp.dart';
import 'package:instagram_app/views/input_phone_number.dart';
import 'package:instagram_app/views/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'phone',
      routes: {
        'phone': (context) => const InputPhoneNumber(),
        'otp': (context) => const InputOTP(),
        'home': (context) => const Home(),

      },
      title: 'Instagram',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
