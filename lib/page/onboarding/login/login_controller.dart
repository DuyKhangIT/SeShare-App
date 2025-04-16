import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/util/global.dart';
import '../../../api_http/handle_api.dart';
import '../../../config/share_preferences.dart';
import '../../../models/login/login_response.dart';
import '../../../models/login/login_request.dart';
import '../../navigation_bar/navigation_bar_view.dart';

class LoginController extends GetxController {
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  String emailLogin = "";
  String passwordLogin = "";
  RxBool isShowPassword = false.obs;

  /// handle api login
  Future<void> login(LoginRequest request) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    LoginResponse loginResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/login"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          request.toBodyRequest(),
        ),
      );
      if (body == null) return;
      //get data from api here
      loginResponse = LoginResponse.fromJson(body);
      if (loginResponse.statusCode == 200) {
        Get.back();
        debugPrint("-----------Login successfully------------");
        Get.back();
        Global.mToken = loginResponse.token!;
        ConfigSharedPreferences()
            .setStringValue(SharedData.TOKEN.toString(), Global.mToken);
        debugPrint("Token: ${Global.mToken}");
        Get.offAll(() => NavigationBarView(currentIndex: 0));
      } else {
        Get.back();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lỗi!',
            message: loginResponse.message,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      Get.back();
      debugPrint("Fail to login $error");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi từ Server!',
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

  void clearTextPhoneLogin() {
    emailLogin = "";
    emailLoginController.clear();
    update();
  }

  void clearTextPasswordLogin() {
    passwordLogin = "";
    passwordLoginController.clear();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailLoginController.clear();
    passwordLoginController.clear();
    super.onClose();
  }
}
