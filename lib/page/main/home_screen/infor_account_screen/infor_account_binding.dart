import 'package:get/get.dart';

import 'infor_account_controller.dart';

class InForAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InForAccountController());
  }
}
