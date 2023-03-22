import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InputPasswordForgotPasswordController extends GetxController{
  TextEditingController newPasswordController = TextEditingController();
  RxString newPassword = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;

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

}