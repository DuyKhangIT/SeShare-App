import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputPhoneNumberForgotPasswordController extends GetxController {
  TextEditingController phoneForgotPasswordController = TextEditingController();
  RxString phoneForgotPassword = RxString("");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryCode = "";
  void clearTextInputPhoneNumber() {
    phoneForgotPassword.value = "";
    phoneForgotPasswordController.clear();
  }

  @override
  void onReady() {
    countryCode = "+84";
    super.onReady();
  }

  // /// CHECK PHONE EXISTING
  // Future<CheckPhoneNumberResponse> checkPhoneExistingForRegister(CheckPhoneNumberRequest checkPhoneNumberRequest) async {
  //   CheckPhoneNumberResponse checkPhoneNumberResponse;
  //   Map<String, dynamic>? body;
  //   try {
  //     body = await HttpHelper.invokeHttp(
  //         Uri.parse("https://seshare-api-production.up.railway.app/api/user/check-phone"),
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
  //      await controller.auth.verifyPhoneNumber(
  //                             phoneNumber: controller.countryCode +
  //                                 controller.phoneForgotPassword.value,
  //                             timeout: const Duration(seconds: 60),
  //                             verificationCompleted:
  //                                 (PhoneAuthCredential credential) {},
  //                             verificationFailed: (FirebaseAuthException e) {
  //                               final snackBar = SnackBar(
  //                                 elevation: 0,
  //                                 behavior: SnackBarBehavior.fixed,
  //                                 backgroundColor: Colors.transparent,
  //                                 content: AwesomeSnackbarContent(
  //                                   title: 'Lỗi!',
  //                                   message: 'Gửi mã otp không thành công!',
  //                                   contentType: ContentType.failure,
  //                                 ),
  //                               );
  //                               ScaffoldMessenger.of(context)
  //                                 ..hideCurrentSnackBar()
  //                                 ..showSnackBar(snackBar);
  //                             },
  //                             codeSent:
  //                                 (String verificationId, int? resendToken) {
  //                               InputPhoneNumberForgotPassword.verify =
  //                                   verificationId;
  //                               Get.to(() => const InputOTPForgotPassword());
  //                             },
  //                             codeAutoRetrievalTimeout: (String verificationId) {
  //                               final snackBar = SnackBar(
  //                                 elevation: 0,
  //                                 behavior: SnackBarBehavior.fixed,
  //                                 backgroundColor: Colors.transparent,
  //                                 content: AwesomeSnackbarContent(
  //                                   title: 'Cảnh báo!',
  //                                   message: 'OTP đã hết hạn!',
  //                                   contentType: ContentType.help,
  //                                 ),
  //                               );
  //                               ScaffoldMessenger.of(context)
  //                                 ..hideCurrentSnackBar()
  //                                 ..showSnackBar(snackBar);
  //                             },
  //                           );
  //   }
  //   else{
  //     final snackBar = SnackBar(
  //       elevation: 0,
  //       behavior: SnackBarBehavior.fixed,
  //       backgroundColor: Colors.transparent,
  //       content: AwesomeSnackbarContent(
  //         title: 'Cảnh báo!',
  //         message: "Số điện thoại chưa đăng ký",
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