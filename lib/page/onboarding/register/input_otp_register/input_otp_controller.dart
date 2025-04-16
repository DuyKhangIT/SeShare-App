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
  bool isLoading = false;

  /// Đếm ngược
  late Timer timer;
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
  Future<VerifyOtpResponse> verifyOTPForRegister(
    VerifyOtpRequest verifyOtpRequest,
  ) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    VerifyOtpResponse verifyOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://localhost:5000/api/auth/verify-otp"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          verifyOtpRequest.toBodyRequest(),
        ),
      );

      if (body == null) return VerifyOtpResponse.buildDefault();
      //get data from api here
      verifyOtpResponse = VerifyOtpResponse.fromJson(body);
      if (verifyOtpResponse.mStatusCode == 200) {
        Get.to(
          () => const RegisterView(),
        );
      } else {
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
      debugPrint("Fail to send otp: $error");
      rethrow;
    } finally {
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
    }

    return verifyOtpResponse;
  }

  @override
  void onClose() {
    timer.cancel();
    start.close();
    super.onClose();
  }
}
