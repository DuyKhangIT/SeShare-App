import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_private_info/update_private_info_controller.dart';

class UpdatePrivateInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdatePrivateInfoController());
  }
}