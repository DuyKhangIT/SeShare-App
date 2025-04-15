import 'package:get/get.dart';

import 'input_email_controller.dart';

class InputEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputEmailController());
  }
}
