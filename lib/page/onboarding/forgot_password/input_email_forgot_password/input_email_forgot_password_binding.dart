import 'package:get/get.dart';

import 'input_email_forgot_password_controller.dart';

class InputEmailForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputEmailForgotPasswordController());
  }
}
