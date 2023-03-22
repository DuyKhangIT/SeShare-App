import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InputPhoneNumberController extends GetxController {
  TextEditingController phoneRegisterController = TextEditingController();
  RxString phoneRegister = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "";
  void clearTextInputPhoneNumber() {
    phoneRegister.value = "";
    phoneRegisterController.clear();
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
