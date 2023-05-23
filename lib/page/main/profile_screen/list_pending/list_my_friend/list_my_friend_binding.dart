import 'package:get/get.dart';

import 'list_my_friend_controller.dart';

class ListMyFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListMyFriendController());
  }
}
