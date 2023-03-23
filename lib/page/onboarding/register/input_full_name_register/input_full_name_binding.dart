import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'input_full_name_controller.dart';

class InputFullNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputFullNameController());
  }
}