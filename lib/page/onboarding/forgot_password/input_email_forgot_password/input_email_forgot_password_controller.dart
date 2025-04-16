import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/forgot_password/input_otp_forgot_password/input_otp_forgot_password_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/register/send_otp/send_otp_request.dart';
import '../../../../models/register/send_otp/send_otp_response.dart';

class InputEmailForgotPasswordController extends GetxController {
  TextEditingController emailForgotPasswordController = TextEditingController();
  RxString emailForgotPassword = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  void clearTextInputEmail() {
    emailForgotPassword.value = "";
    emailForgotPasswordController.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // /// SEND OTP
  Future<void> sendOTPForForgotPassword(
    SendOtpRequest sendOtpRequest,
  ) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    SendOtpResponse sendOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/forgot-password/send-otp"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          sendOtpRequest.toBodyRequest(),
        ),
      );

      if (body == null) return;
      //get data from api here
      sendOtpResponse = SendOtpResponse.fromJson(body);
      if (sendOtpResponse.mStatusCode == 200) {
        Get.back();
        Get.to(
          () => InputOTPForgotPassword(
            emailForgot: emailForgotPassword.value,
          ),
        );
      } else {
        Get.back();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Lỗi!',
            message: sendOtpResponse.message,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      Get.back();
      debugPrint("Fail to send otp forgotPassword: $error");
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

  @override
  void onClose() {
    super.onClose();
  }
}
