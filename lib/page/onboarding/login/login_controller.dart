import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../api_http/handle_api.dart';
import '../../../config/share_preferences.dart';
import '../../../models/login_response/authentication_response.dart';
import '../../../models/user_request.dart';
import '../../main/home_screen/home_view.dart';
import '../../navigation_bar/navigation_bar_view.dart';
import 'login_view.dart';

class LoginController extends GetxController {
  UserRequest? userRequest;
  TextEditingController phoneLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  String phoneLogin = "";
  String passwordLogin = "";
  RxBool isLoading = false.obs;
  RxBool isShowPassword = false.obs;


  /// handle api login
  Future<AuthenticationResponse> authenticate(UserRequest request) async {
    isLoading.value = true;
    AuthenticationResponse authenticationResponse;
    Map<String, dynamic>? body;
    //is this for string quere only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "https://seshare-api-production.up.railway.app/api/user/login"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to login $error");
      isLoading.value = false;
      rethrow;
    }
    if (body == null) return AuthenticationResponse.buildDefault();
    //get data from api here
    authenticationResponse = AuthenticationResponse.fromJson(body);
    isLoading.value = false;
    ConfigSharedPreferences().setStringValue(
        SharedData.TOKEN.toString(),
        authenticationResponse.mToken!);
    Get.to(() => const NavigationBarView());
    return authenticationResponse;
  }

  void clearTextPhoneLogin() {
    phoneLogin = "";
    phoneLoginController.clear();
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
