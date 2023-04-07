import 'package:get/get.dart';

import '../../../config/share_preferences.dart';
import '../../navigation_bar/navigation_bar_view.dart';
import '../login/login_view.dart';

class StartUpController extends GetxController{
  RxBool isNewUser = false.obs;

  @override
  void onInit() {
    checkAlreadyLoggedIn();
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  /// check login with shared preferences
  Future<void> checkAlreadyLoggedIn() async {
    String? userId = await ConfigSharedPreferences().getStringValue(
        SharedData.TOKEN.toString(),
        defaultValue: "");
    if (userId.isEmpty || userId == "") {
      isNewUser.value = true;
    } else {
      loadData();
    }
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    isNewUser.value = false;
    Get.to(() =>  const NavigationBarView());
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}