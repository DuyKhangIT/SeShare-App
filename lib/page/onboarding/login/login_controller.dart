import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/src/response.dart' as res;
import '../../../api_http/api_http.dart';
import '../../../models/login_response/authentication_response.dart';
import '../../../models/login_response/user_response.dart';
import '../../../models/user_request.dart';
class LoginController extends GetxController{
  TextEditingController phoneLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  RxString phoneLogin = RxString("");
  RxString passwordLogin = RxString("");


  Future<AuthenticationResponse> authenticate(UserRequest request) async {
    AuthenticationResponse authenticationResponse;
    Map<String, dynamic>? body;
    //is this for string quere only
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("https://seshare-api-production.up.railway.app/api/user/login"), RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to login $error");
      rethrow;
    }
    if (body == null) return AuthenticationResponse.buildDefault();
    //get data from api here
    print(body);
    authenticationResponse = AuthenticationResponse.fromJson(body);
    return authenticationResponse;
  }


  void clearTextPhoneLogin() {
    phoneLogin.value = "";
    phoneLoginController.clear();
  }

  void clearTextPasswordLogin() {
    passwordLogin.value = "";
    passwordLoginController.clear();
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
