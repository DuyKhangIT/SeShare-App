import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'changed_address_controller.dart';

class ChangedAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangedAddressController());
  }
}