import 'package:get/get.dart';

import 'list_pending_controller.dart';

class ListPendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListPendingController());
  }
}
