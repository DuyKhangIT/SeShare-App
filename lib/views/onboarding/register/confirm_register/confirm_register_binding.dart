import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:instagram_app/views/onboarding/register/confirm_register/confirm_register_controller.dart';

class ConfirmRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmRegisterController());
  }
}