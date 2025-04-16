import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/register/verify_otp/verify_otp_request.dart';

import 'package:instagram_app/widget/button_next.dart';
import 'package:pinput/pinput.dart';
import '../../../../util/global.dart';
import 'input_otp_forgot_password_controller.dart';

class InputOTPForgotPassword extends StatefulWidget {
  final String emailForgot;
  const InputOTPForgotPassword({
    Key? key,
    required this.emailForgot,
  }) : super(key: key);

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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).textTheme.headlineMedium?.color,
                      fontSize: 20),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
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
                        "Nhập mã OTP",
                        style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(
                              text: "Chúng tôi đã gửi mã OTP tới ",
                            ),
                            TextSpan(
                              text: widget.emailForgot,
                              style: const TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                          if (otpForgotPasswordController.otp.value.isEmpty) {
                            final snackBar = SnackBar(
                              /// need to set following properties for best effect of awesome_snackbar_content
                              elevation: 0,
                              behavior: SnackBarBehavior.fixed,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Cánh báo!',
                                message:
                                    'Bạn chưa nhập mã otp! Vui lòng nhập mã otp',
                                contentType: ContentType.help,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          } else {
                            VerifyOtpRequest request = VerifyOtpRequest(
                              widget.emailForgot,
                              otpForgotPasswordController.otp.value,
                            );
                            otpForgotPasswordController
                                .verifyOTPForgotPassword(request);
                          }
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
                                        otpForgotPasswordController.timer
                                            .cancel();
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
