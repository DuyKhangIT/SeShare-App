import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/util/global.dart';
import '../../../api_http/handle_api.dart';
import '../../../config/share_preferences.dart';
import '../../../models/login/authentication_response.dart';
import '../../../models/login/user_request.dart';
import '../../navigation_bar/navigation_bar_view.dart';

class LoginController extends GetxController {
  UserRequest? userRequest;
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  String emailLogin = "";
  String passwordLogin = "";
  RxBool isLoading = false.obs;
  RxBool isShowPassword = false.obs;


  /// handle api login
  Future<AuthenticationResponse> authenticate(UserRequest request) async {
    isLoading.value = true;
    if (isLoading.value) {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    AuthenticationResponse authenticationResponse;
    Map<String, dynamic>? body;
    //is this for string query only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/login"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to login $error");
      rethrow;
    }
    if (body == null) return AuthenticationResponse.buildDefault();
    //get data from api here
    authenticationResponse = AuthenticationResponse.fromJson(body);
    if(authenticationResponse.status == false){
      isLoading.value = false;
      if (isLoading.value) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Cảnh báo!',
          message: "Số điện thoại hoặc mật khẩu không chính xác",
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }else{
      debugPrint("-----------Login successfully------------");
      isLoading.value = false;
      if (isLoading.value) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      Global.mToken = authenticationResponse.token!;
      ConfigSharedPreferences().setStringValue(
          SharedData.TOKEN.toString(),
          Global.mToken);
      debugPrint(Global.mToken);
      Get.offAll(() =>  NavigationBarView(currentIndex: 0));
    }
    return authenticationResponse;
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
    super.onClose();
  }
}
