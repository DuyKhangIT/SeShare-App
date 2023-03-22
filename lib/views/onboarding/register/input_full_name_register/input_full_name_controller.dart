import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputFullNameController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  RxString fullName = RxString("");


  void clearTextFullName() {
    fullName.value = "";
    fullNameController.clear();
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