import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputBirthdayController extends GetxController {
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  RxString day = RxString("");
  RxString month = RxString("");
  RxString year = RxString("");
  String birthDay = "";

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}