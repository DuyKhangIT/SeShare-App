import 'package:get/get.dart';

import 'input_birthday_controller.dart';


class InputBirthdayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputBirthdayController());
  }
}