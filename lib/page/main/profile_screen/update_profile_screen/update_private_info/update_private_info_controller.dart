import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/update_user_profile/update_user_profile_request.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';

import '../../../../../api_http/handle_api.dart';
import '../../../../../models/user_profile/profile_response.dart';
import '../../../../../util/global.dart';


class UpdatePrivateInfoController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  String gender = "";
  String birthDay = "";
  bool isLoading = false;
  String place = "";
  @override
  void onReady() {
    phoneNumberController.text = Global.userProfileResponse!.phone;
    genderController.text = Global.userProfileResponse!.gender!;
    birthDayController.text = Global.userProfileResponse!.age;
    placeController.text = Global.userProfileResponse!.place;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateUserProfile() {
      UpdateUserProfileRequest updateUserProfileRequest =
          UpdateUserProfileRequest(
              genderController.text,
              Global.userProfileResponse!.fullName,
              placeController.text,
              Global.userProfileResponse!.avatarPath!,
              Global.userProfileResponse!.bio!,
              Global.userProfileResponse!.backgroundPath!,
              birthDayController.text);
      updateProfile(updateUserProfileRequest);

  }

  /// handle update user profile api
  Future<ProfileResponse> updateProfile(
      UpdateUserProfileRequest updateUserProfileRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    ProfileResponse profileResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/user/updale-profile"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(updateUserProfileRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to update user profile $error");
      rethrow;
    }
    if (body == null) return ProfileResponse.buildDefault();
    //get data from api here
    profileResponse = ProfileResponse.fromJson(body);
    if (profileResponse.status == true) {
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thành công!',
          message: "Cập nhật thông tin cá nhân thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Global.userProfileResponse = profileResponse.userProfileResponse;
      Get.offAll(() => NavigationBarView(currentIndex: 4));
    } else {
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thất bại!',
          message: "Cập nhật thông tin cá nhân thất bại",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    return profileResponse;
  }
}
