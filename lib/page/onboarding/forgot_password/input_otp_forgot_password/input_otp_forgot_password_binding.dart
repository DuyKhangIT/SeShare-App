import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'input_otp_forgot_password_controller.dart';

class InputOTPForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputOTPForgotPasswordController());
  }
}