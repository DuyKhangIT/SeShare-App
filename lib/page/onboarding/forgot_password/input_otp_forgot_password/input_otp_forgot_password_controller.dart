import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InputOTPForgotPasswordController extends GetxController{
  TextEditingController otpController = TextEditingController();
  RxString otp = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;

  late Timer timer;
  /// Đếm ngược
  var start = 59.obs;
  String countryCode = "";
  void startTimer() {
    start.value = 59;
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  @override
  void onReady() {
    startTimer();
    countryCode = "+84";
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}