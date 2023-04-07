import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isTyping = false;
  @override
  void onReady() {
    messageController.addListener(onTextTyping);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  // void clearTextSearch() {
  //   inputSearch = "";
  //   searchController.clear();
  //   update();
  // }

  void onTextTyping() {
    if (!isTyping && messageController.text.isNotEmpty) {
      isTyping = true;
      update();
      return;
    }

    if (isTyping && messageController.text.isEmpty) {
      isTyping = false;
      update();
    }
  }
}