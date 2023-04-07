import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatListController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String inputSearch = "";
  bool isSearching = false;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void clearTextSearch() {
    inputSearch = "";
    searchController.clear();
    update();
  }
}
