import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/story_data.dart';

class HomeController extends GetxController {
  bool isLike = false;
  final scrollController = ScrollController();
  double previousOffset = 0.0;
  File? avatar;
  bool isNewUpdate = false;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // /// refresh
  // Future<void> refreshData() async {
  //   showNewProblem = false;
  //   refreshUI();
  //   loadData();
  // }
  //
  // @override
  //
  /// pull to refresh
  Future<void> pullToRefreshData({bool isRefreshIndicator = true}) async {
    isNewUpdate = false;
    // showNewProblem = false;
    // loadData();
    // refreshUI();
    //if (isRefreshIndicator) hideLoadingProgress();
    return Future.delayed(const Duration(seconds: 1));
  }
}
