import 'package:get/get.dart';
import 'package:instagram_app/views/home.dart';
import 'package:instagram_app/views/input_phone_number.dart';

import '../config/share_preferences.dart';

class CheckLogIned extends GetxController{
  void checkAlreadyLoggedIn() async {
    String? userId = await ConfigSharedPreferences().getStringValue(
        SharedData.USER_ID.toString(),
        defaultValue: "");
    if (userId.isEmpty || userId == "") {
      Get.to(() => const InputPhoneNumber());
    } else {
      Get.to(() => const Home());
    }
  }
}