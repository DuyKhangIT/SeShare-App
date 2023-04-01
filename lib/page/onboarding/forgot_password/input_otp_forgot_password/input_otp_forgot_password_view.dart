import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_app/widget/button_next.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/share_preferences.dart';
import '../../../../util/global.dart';
import '../input_password_forgot_password/input_password_forgot_password_view.dart';
import 'input_otp_forgot_password_controller.dart';

class InputOTPForgotPassword extends StatefulWidget {
  const InputOTPForgotPassword({Key? key}) : super(key: key);

  @override
  State<InputOTPForgotPassword> createState() => _InputOTPForgotPasswordState();
}

class _InputOTPForgotPasswordState extends State<InputOTPForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    InputOTPForgotPasswordController otpForgotPasswordController =
        Get.put(InputOTPForgotPasswordController());
    return GetBuilder<InputOTPForgotPasswordController>(
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text(
                  'Quên mật khẩu',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontSize: 20),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
              ),
              body: Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SeShare',
                        style: TextStyle(
                            fontSize: 49,
                            fontFamily: 'Nunito Sans',
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Nhập mã OTP",
                        style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Chúng tôi đã gửi tới bạn mã OTP",
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Pinput(
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        length: 6,
                        showCursor: true,
                        onChanged: (value) {
                          otpForgotPasswordController.otp.value = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      /// button next
                      ButtonNext(
                        onTap: () async {
                          Get.to(() => const InputPasswordForgotPassword());
                          // if (otpForgotPasswordController.otp.value.isEmpty) {
                          //   final snackBar = SnackBar(
                          //     /// need to set following properties for best effect of awesome_snackbar_content
                          //     elevation: 0,
                          //     behavior: SnackBarBehavior.fixed,
                          //     backgroundColor: Colors.transparent,
                          //     content: AwesomeSnackbarContent(
                          //       title: 'Cánh báo!',
                          //       message:
                          //           'Bạn chưa nhập mã otp! Vui lòng nhập mã otp',
                          //       contentType: ContentType.help,
                          //     ),
                          //   );
                          //   ScaffoldMessenger.of(context)
                          //     ..hideCurrentSnackBar()
                          //     ..showSnackBar(snackBar);
                          // } else {
                          //   try {
                          //     // Create a PhoneAuthCredential with the code
                          //     PhoneAuthCredential credential =
                          //         PhoneAuthProvider.credential(
                          //             verificationId: Global.verifyFireBase,
                          //             smsCode: otpForgotPasswordController
                          //                 .otp.value);
                          //     // Sign the user in (or link) with the credential
                          //     await otpForgotPasswordController.auth
                          //         .signInWithCredential(credential);
                          //     // ConfigSharedPreferences().setStringValue(
                          //     //     SharedData.USER_ID.toString(),
                          //     //     auth.currentUser!.uid);
                          //     Get.to(() => const InputPasswordForgotPassword());
                          //   } catch (e) {
                          //     final snackBar = SnackBar(
                          //       elevation: 0,
                          //       behavior: SnackBarBehavior.fixed,
                          //       backgroundColor: Colors.transparent,
                          //       content: AwesomeSnackbarContent(
                          //         title: 'Lỗi!',
                          //         message:
                          //             'Bạn nhập sai mã otp! Vui lòng nhập lại',
                          //         contentType: ContentType.failure,
                          //       ),
                          //     );
                          //     ScaffoldMessenger.of(context)
                          //       ..hideCurrentSnackBar()
                          //       ..showSnackBar(snackBar);
                          //   }
                          // }
                        },
                        textInside: "Xác nhận OTP",
                      ),
                      Center(
                        child: Obx(() {
                          return (otpForgotPasswordController.start.value == 0)
                              ? TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                      phoneNumber: otpForgotPasswordController
                                              .countryCode +
                                          Global.phoneNumber,
                                      timeout: const Duration(seconds: 60),
                                      verificationCompleted:
                                          (PhoneAuthCredential
                                              credential) async {
                                            otpForgotPasswordController
                                                .timer.cancel();
                                          },
                                      verificationFailed:
                                          (FirebaseAuthException e) {},
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        Global.verifyFireBase = verificationId;
                                        otpForgotPasswordController
                                            .startTimer();
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
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
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      },
                                      forceResendingToken: null,
                                    );
                                  },
                                  child: const Text('Gửi lại mã',
                                      style: TextStyle(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 16)),
                                )
                              : TextButton(
                                  onPressed: () {},
                                  child: Text(
                                      '${otpForgotPasswordController.start.value}'
                                      's',
                                      style: const TextStyle(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 16)));
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
