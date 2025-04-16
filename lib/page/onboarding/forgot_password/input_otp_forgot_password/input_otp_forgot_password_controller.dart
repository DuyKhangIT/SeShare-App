import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/page/onboarding/forgot_password/input_password_forgot_password/input_password_forgot_password_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/register/verify_otp/verify_otp_request.dart';
import '../../../../models/register/verify_otp/verify_otp_response.dart';

class InputOTPForgotPasswordController extends GetxController {
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

  Future<void> verifyOTPForgotPassword(
    VerifyOtpRequest verifyOtpRequest,
  ) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    VerifyOtpResponse verifyOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/forgot-password/verify-otp"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          verifyOtpRequest.toBodyRequest(),
        ),
      );

      if (body == null) return;
      //get data from api here
      verifyOtpResponse = VerifyOtpResponse.fromJson(body);
      if (verifyOtpResponse.mStatusCode == 200) {
        Get.back();
        Get.to(
          () => InputPasswordForgotPassword(
            emil: verifyOtpRequest.mEmail,
          ),
        );
      } else {
        Get.back();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lôi!',
            message: verifyOtpResponse.message,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      Get.back();
      debugPrint("Fail to verify otp: $error");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi từ server!',
          message: error.toString(),
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      rethrow;
    }

    return;
  }
}
