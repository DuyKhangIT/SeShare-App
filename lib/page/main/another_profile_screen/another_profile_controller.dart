import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../util/global.dart';

class AnOtherProfileController extends GetxController {
  List<String> listPhotos = [];
  String background = "";
  String avatar = "";
  String fullName = "";
  String bio = "";
  bool isLoading = false;
  @override
  void onReady() {
    listPhotos = Global.listPhotoAnOtherUser;
    background = Global.anOtherUserProfileResponse!.backgroundPath!;
    avatar = Global.anOtherUserProfileResponse!.avatarPath!;
    fullName = Global.anOtherUserProfileResponse!.fullName;
    bio = Global.anOtherUserProfileResponse!.bio!;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
