import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'chat_list_controller.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatListController());
  }
}
