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
  bool isLoading = false;
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
  Future<SendOtpResponse> sendOTPForRegister(
    SendOtpRequest sendOtpRequest,
  ) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    SendOtpResponse sendOtpResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse("http://localhost:5000/api/auth/send-otp"),
        RequestType.post,
        headers: null,
        body: const JsonEncoder().convert(
          sendOtpRequest.toBodyRequest(),
        ),
      );

      if (body == null) return SendOtpResponse.buildDefault();
      //get data from api here
      sendOtpResponse = SendOtpResponse.fromJson(body);
      if (sendOtpResponse.mStatusCode == 200) {
        Get.to(
          () => InputOTP(
            emailRegister: emailRegister.value,
          ),
        );
      } else {
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

    return sendOtpResponse;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
