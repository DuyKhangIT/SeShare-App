import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'navigation_bar_controller.dart';

class NavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationBarController());
  }
}