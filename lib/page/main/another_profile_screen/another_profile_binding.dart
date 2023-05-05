import 'package:get/get.dart';

import 'another_profile_controller.dart';

class AnOtherProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnOtherProfileController());
  }
}
