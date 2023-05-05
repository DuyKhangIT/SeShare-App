import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
