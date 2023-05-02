import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController());
  }
}