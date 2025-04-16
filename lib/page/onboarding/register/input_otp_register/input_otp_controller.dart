import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_app/page/onboarding/register/register_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/register/verify_otp/verify_otp_request.dart';
import '../../../../models/register/verify_otp/verify_otp_response.dart';

class InputOTPController extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxString otp = RxString("");

  /// Đếm ngược
  var start = 59.obs;

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
    super.onReady();
  }

  // /// VERIFY OTP
  Future<void> verifyOTPForRegister(
    VerifyOtpRequest verifyOtpRequest,
  ) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    VerifyOtpResponse verifyOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/verify-otp"),
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
          () => RegisterView(
            email: verifyOtpRequest.mEmail,
          ),
        );
      } else {
        Get.back();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Cảnh báo!',
            message: verifyOtpResponse.message,
            contentType: ContentType.help,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      Get.back();
      debugPrint("Fail to send otp: $error");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Cảnh báo!',
          message: error.toString(),
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      rethrow;
    }

    return;
  }

  @override
  void onClose() {
    start.close();
    super.onClose();
  }
}
