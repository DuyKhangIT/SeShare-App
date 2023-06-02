import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/change_password/change_password_request.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_screen.dart';

import '../../../../../api_http/handle_api.dart';
import '../../../../../models/change_password/change_password_response.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  String oldPassword = "";
  String newPassword = "";
  String confirmNewPassword = "";
  bool isTyping = false;
  bool isLoading = false;
  RxBool isShowOldPassword = false.obs;
  RxBool isShowNewPassword = false.obs;
  RxBool isShowConfirmNewPassword = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// handle api change password
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    update();
    ChangePasswordResponse changePasswordResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/user/change-password"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to change password $error");
      rethrow;
    }
    if (body == null) return ChangePasswordResponse.buildDefault();
    //get data from api here
    changePasswordResponse = ChangePasswordResponse.fromJson(body);
    if(changePasswordResponse.status == true){
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      update();
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thành công!',
          message: "Đổi mật khẩu thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Get.offAll(() =>  const SettingScreen());
    }else{
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thất bại!',
          message: "Lỗi Đổi mật khẩu không thành công",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    return changePasswordResponse;
  }
}
