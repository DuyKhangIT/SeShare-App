import 'package:get/get.dart';

import 'action_search_controller.dart';

class ActionSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActionSearchController());
  }
}