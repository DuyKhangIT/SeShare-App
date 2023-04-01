import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/assets/assets.dart';

import '../../../assets/images_assets.dart';

class SearchController extends GetxController {
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
  // /// searching
  // void updateSearch(String value) {
  //   result = data
  //       .where((element) => accentParser(element.mVendorName)
  //       .toLowerCase()
  //       .contains(accentParser(value).toLowerCase()))
  //       .toList();
  //   isSearching = value.isNotEmpty;
  //   update();
  // }
}
