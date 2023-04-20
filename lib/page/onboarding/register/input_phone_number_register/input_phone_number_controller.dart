import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/register_response/check_existing_phone_number/check_phone_number_request.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/register_response/check_existing_phone_number/check_phone_number_response.dart';
import '../../../../util/global.dart';
import '../../../../util/module.dart';
import '../input_otp_register/input_otp_view.dart';

class InputPhoneNumberController extends GetxController {
  TextEditingController phoneRegisterController = TextEditingController();
  RxString phoneRegister = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "";
  bool isLoading = false;
  void clearTextInputPhoneNumber() {
    phoneRegister.value = "";
    phoneRegisterController.clear();
  }

  @override
  void onReady() {
    countryCode = "+84";
    super.onReady();
  }

  // /// CHECK PHONE EXISTING
  Future<CheckPhoneNumberResponse> checkPhoneExistingForRegister(CheckPhoneNumberRequest checkPhoneNumberRequest) async {
    isLoading = true;
    if (isLoading) {
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    } else {
      Get.back(); // Đóng hộp thoại loading nếu isLoading = false
    }
    CheckPhoneNumberResponse checkPhoneNumberResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("https://seshareapi.onrender.com/api/user/check-phone"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(checkPhoneNumberRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to check phone existing $error");
      rethrow;
    }
    if (body == null) return CheckPhoneNumberResponse.buildDefault();
    //get data from api here
    checkPhoneNumberResponse = CheckPhoneNumberResponse.fromJson(body);
    if(checkPhoneNumberResponse.status == true)
    {
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      await auth.verifyPhoneNumber(
        phoneNumber: countryCode + removeZeroAtFirstDigitPhoneNumber(phoneRegister.value),
        timeout: const Duration(seconds: 60),
        verificationCompleted:
            (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Lỗi!',
              message: 'Gửi mã otp không thành công!',
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(Get.context!)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? resendToken) {
          Global.verifyFireBase = verificationId;
          Get.to(() => const InputOTP());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Cảnh báo!',
              message: 'OTP đã hết hạn!',
              contentType: ContentType.help,
            ),
          );
          ScaffoldMessenger.of(Get.context!)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
      );
    }
    else{
      isLoading = false;
      if (isLoading) {
        Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      } else {
        Get.back(); // Đóng hộp thoại loading nếu isLoading = false
      }
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Cảnh báo!',
          message: checkPhoneNumberResponse.userContent,
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    return checkPhoneNumberResponse;
  }



  @override
  void onClose() {
    super.onClose();
  }
}
