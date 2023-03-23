import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputPhoneNumberForgotPasswordController extends GetxController {
  TextEditingController phoneForgotPasswordController = TextEditingController();
  RxString phoneForgotPassword = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "";
  void clearTextInputPhoneNumber() {
    phoneForgotPassword.value = "";
    phoneForgotPasswordController.clear();
  }

  @override
  void onReady() {
    countryCode = "+84";
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}