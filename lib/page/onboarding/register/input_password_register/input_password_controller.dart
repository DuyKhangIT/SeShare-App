import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputPasswordController extends GetxController{
  TextEditingController passwordController = TextEditingController();
  RxString password = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;

  void clearTextInputPassword() {
    password.value = "";
  passwordController.clear();
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