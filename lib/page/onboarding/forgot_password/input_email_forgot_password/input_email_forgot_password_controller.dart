import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/forgot_password/input_otp_forgot_password/input_otp_forgot_password_view.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../util/global.dart';
import '../../../../util/module.dart';

class InputEmailForgotPasswordController extends GetxController {
  TextEditingController emailForgotPasswordController = TextEditingController();
  RxString emailForgotPassword = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "";
  bool isLoading = false;
  void clearTextInputEmail() {
    emailForgotPassword.value = "";
    emailForgotPasswordController.clear();
  }

  @override
  void onReady() {
    countryCode = "+84";
    super.onReady();
  }

  // // /// CHECK PHONE EXISTING
  // Future<CheckPhoneNumberResponse> checkPhoneExistingForgotPassword(CheckPhoneNumberRequest checkPhoneNumberRequest) async {
  //   isLoading = true;
  //   if (isLoading) {
  //     Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
  //   } else {
  //     Get.back(); // Đóng hộp thoại loading nếu isLoading = false
  //   }
  //   CheckPhoneNumberResponse checkPhoneNumberResponse;
  //   Map<String, dynamic>? body;
  //   try {
  //     body = await HttpHelper.invokeHttp(
  //         Uri.parse("http://14.225.204.248:8080/api/check-phone"),
  //         RequestType.post,
  //         headers: null,
  //         body: const JsonEncoder().convert(checkPhoneNumberRequest.toBodyRequest()));
  //   } catch (error) {
  //     debugPrint("Fail to check phone existing $error");
  //     rethrow;
  //   }
  //   if (body == null) return CheckPhoneNumberResponse.buildDefault();
  //   //get data from api here
  //   checkPhoneNumberResponse = CheckPhoneNumberResponse.fromJson(body);
  //   if(checkPhoneNumberResponse.status == false)
  //   {
  //     isLoading = false;
  //     if (isLoading) {
  //       Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
  //     } else {
  //       Get.back(); // Đóng hộp thoại loading nếu isLoading = false
  //     }
  //     await auth.verifyPhoneNumber(
  //       phoneNumber: countryCode + removeZeroAtFirstDigitPhoneNumber(emailForgotPassword.value),
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted:
  //           (PhoneAuthCredential credential) {},
  //       verificationFailed: (FirebaseAuthException e) {},
  //       codeSent: (String verificationId, int? resendToken) {
  //         Global.verifyFireBase = verificationId;
  //         // Get.to(() => const InputOTPForgotPassword());
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         final snackBar = SnackBar(
  //           elevation: 0,
  //           behavior: SnackBarBehavior.fixed,
  //           backgroundColor: Colors.transparent,
  //           content: AwesomeSnackbarContent(
  //             title: 'Cảnh báo!',
  //             message: 'OTP đã hết hạn!',
  //             contentType: ContentType.help,
  //           ),
  //         );
  //         ScaffoldMessenger.of(Get.context!)
  //           ..hideCurrentSnackBar()
  //           ..showSnackBar(snackBar);
  //       },
  //     );
  //   }
  //   else{
  //     isLoading = false;
  //     if (isLoading) {
  //       Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
  //     } else {
  //       Get.back(); // Đóng hộp thoại loading nếu isLoading = false
  //     }
  //     final snackBar = SnackBar(
  //       elevation: 0,
  //       behavior: SnackBarBehavior.fixed,
  //       backgroundColor: Colors.transparent,
  //       content: AwesomeSnackbarContent(
  //         title: 'Cảnh báo!',
  //         message: 'Số điện thoại chưa đăng kí',
  //         contentType: ContentType.help,
  //       ),
  //     );
  //     ScaffoldMessenger.of(Get.context!)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //   }
  //
  //   return checkPhoneNumberResponse;
  // }

  @override
  void onClose() {
    super.onClose();
  }
}