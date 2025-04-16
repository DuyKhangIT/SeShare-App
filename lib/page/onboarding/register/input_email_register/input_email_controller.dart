import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/register/send_otp/send_otp_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/register/send_otp/send_otp_request.dart';
import '../input_otp_register/input_otp_view.dart';

class InputEmailController extends GetxController {
  TextEditingController emailRegisterController = TextEditingController();
  RxString emailRegister = RxString("");
  void clearTextInputPhoneNumber() {
    emailRegister.value = "";
    emailRegisterController.clear();
    update();
  }

  void updateEmailInput(String email) {
    emailRegister.value = email;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // /// SEND OTP
  Future<void> sendOTPForRegister(
    SendOtpRequest sendOtpRequest,
  ) async {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    SendOtpResponse sendOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://10.0.2.2:5000/api/auth/send-otp"),
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
          () => InputOTP(
            emailRegister: emailRegister.value,
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
            message: sendOtpResponse.message,
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
          title: 'Lỗi!',
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
    super.onClose();
  }
}
