import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'input_phone_number_controller.dart';

class InputPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputPhoneNumberController());
  }
}