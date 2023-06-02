import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instagram_app/util/global.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


import 'config/theme_service.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.instance
      .getToken()
      .then((value) => {debugPrint("get token: $value"),});

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
        (RemoteMessage message) async {
          debugPrint("openMessageOpenedApp: $message");
    };
  });

  FirebaseMessaging.instance.getInitialMessage().then((value) => {});

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    debugPrint("Accepted permission: $accepted");
  });

  await OneSignal.shared.setAppId("95e65145-2b37-4da7-aa7d-d3a540a418b9");

  await OneSignal.shared.getDeviceState().then((value) => {
    debugPrint(value!.userId),
    Global.tokenOneSignal = value.userId!
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
          (OSNotificationReceivedEvent event) {
        // Will be called whenever a notification is received in foreground
        // Display Notification, pass null param for not displaying the notification
        event.complete(event.notification);
      });

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("_firebaseMessagingBackgroundHandler: $message");
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
      initialRoute: AppRoutes.startUpScreen,
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
         Locale('vi', 'VN'), // Định nghĩa ngôn ngữ là tiếng Việt
      ],
      getPages: AppRoutes.pages,
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileScreenLayout(),
      //     webScreenLayout: WebScreenLayout()),
    );
  }
}
