import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/get_all_photo_user/get_all_photo_user_response.dart';

import '../../../api_http/handle_api.dart';

class ProfileController extends GetxController {
  List<String>listPhotos = [];
  bool isLoading = false;
  @override
  void onReady() {
    getListPhotoUser();
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// call api list post
  Future<GetAllPhotoUserResponse> getListPhotoUser() async {
    isLoading = true;
    update();
    GetAllPhotoUserResponse getAllPhotoUserResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/get-list-photos-user"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list photos $error");
      rethrow;
    }
    if (body == null) return GetAllPhotoUserResponse.buildDefault();
    //get data from api here
    getAllPhotoUserResponse = GetAllPhotoUserResponse.fromJson(body);
    if (getAllPhotoUserResponse.status == true) {
      listPhotos = getAllPhotoUserResponse.listPhotosUser!;
      await Future.delayed(const Duration(seconds: 1),(){});
      isLoading = false;
      update();
    }
    return getAllPhotoUserResponse;
  }
}
