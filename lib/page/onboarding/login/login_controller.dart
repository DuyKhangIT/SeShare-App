import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  TextEditingController phoneLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  RxString phoneLogin = RxString("");
  RxString passwordLogin = RxString("");


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
