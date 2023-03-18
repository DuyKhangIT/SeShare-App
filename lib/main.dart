import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/views/home/home.dart';
import 'package:instagram_app/views/onboarding/forgot_password/input_otp_for_forgot_password.dart';
import 'package:instagram_app/views/onboarding/forgot_password/input_password_for_forgot_password.dart';
import 'package:instagram_app/views/onboarding/forgot_password/input_phone_number_for_forgot_password.dart';
import 'package:instagram_app/views/onboarding/login/login.dart';
import 'package:instagram_app/views/onboarding/register/confirm_register.dart';
import 'package:instagram_app/views/onboarding/register/input_full_name.dart';
import 'package:instagram_app/views/onboarding/register/input_otp.dart';
import 'package:instagram_app/views/onboarding/register/input_password.dart';
import 'package:instagram_app/views/onboarding/register/input_phone_number.dart';
import 'package:instagram_app/views/onboarding/start_up.dart';
import 'package:instagram_app/views/onboarding/register/upload_avatar_for_register.dart';

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
      initialRoute: 'password',
      routes: {
        'startUp': (context) => const StartUpScreen(),
        /// login
        'login': (context) => const Login(),
        /// forgot password
        'phoneForgotPassword': (context) => const InputPhoneNumberForgotPassword(),
        'otpForgotPassword': (context) => const InputOTPForgotPassword(),
        'inputPasswordForgotPassword': (context) => const InputPasswordForgotPassword(),
        /// register
        'phone': (context) => const InputPhoneNumber(),
        'otp': (context) => const InputOTP(),
        'password': (context) => const InputPassword(),
        'fullName': (context) => const InputFullName(),
        'uploadAvatar': (context) => const UploadAvatarForRegister(),
        'confirmRegister': (context) => const ConfirmRegister(),
        /// home
        'home': (context) => const Home(),
      },
      title: 'Images',
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
