import 'package:get/get.dart';

import '../config/share_preferences.dart';
import '../page/main/home_screen/home_view.dart';
import '../page/onboarding/login/login_view.dart';

class CheckLogIned extends GetxController{
  void checkAlreadyLoggedIn() async {
    String? userId = await ConfigSharedPreferences().getStringValue(
        SharedData.TOKEN.toString(),
        defaultValue: "");
    if (userId.isEmpty || userId == "") {
      Get.to(() =>  Login());
    } else {
      Get.to(() => const Home());
    }
  }
}