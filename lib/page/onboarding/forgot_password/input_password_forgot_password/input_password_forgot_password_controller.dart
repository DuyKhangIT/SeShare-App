import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/forgot_password/forgot_password_request.dart';
import 'package:instagram_app/models/forgot_password/forgot_password_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../login/login_view.dart';

class InputPasswordForgotPasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  RxString newPassword = RxString("");
  RxBool isShowPassword = false.obs;
  void clearTextInputPassword() {
    newPassword.value = "";
    newPasswordController.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// handle api forgot password
  Future<void> resetPassword(ForgotPasswordRequest request) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    ForgotPasswordResponse forgotPasswordResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/forgot-password/reset"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          request.toBodyRequest(),
        ),
      );
      if (body == null) return;
      //get data from api here
      forgotPasswordResponse = ForgotPasswordResponse.fromJson(body);
      if (forgotPasswordResponse.statusCode == 200) {
        Get.back();
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
        Get.offAll(() => Login());
      } else {
        Get.back();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lỗi!',
            message: forgotPasswordResponse.message,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      debugPrint("Fail to forgot password $error");
      Get.back();
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi từ server!',
          message: error.toString(),
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      rethrow;
    }

    return;
  }
}
