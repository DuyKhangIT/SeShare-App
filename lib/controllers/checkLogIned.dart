import 'package:get/get.dart';
import 'package:instagram_app/views/home/home.dart';

import '../config/share_preferences.dart';
import '../views/onboarding/login/login.dart';

class CheckLogIned extends GetxController{
  void checkAlreadyLoggedIn() async {
    String? userId = await ConfigSharedPreferences().getStringValue(
        SharedData.USER_ID.toString(),
        defaultValue: "");
    if (userId.isEmpty || userId == "") {
      Get.to(() => const Login());
    } else {
      Get.to(() => const Home());
    }
  }
}