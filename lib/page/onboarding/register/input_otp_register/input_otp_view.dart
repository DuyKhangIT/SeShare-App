import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/register/verify_otp/verify_otp_request.dart';

import 'package:instagram_app/widget/button_next.dart';
import 'package:pinput/pinput.dart';
import '../../login/login_view.dart';
import 'input_otp_controller.dart';

class InputOTP extends StatefulWidget {
  final String emailRegister;

  const InputOTP({
    Key? key,
    required this.emailRegister,
  }) : super(key: key);

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP> {
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
    InputOTPController inputOTPController = Get.put(InputOTPController());
    return GetBuilder<InputOTPController>(
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Đăng ký',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).textTheme.headlineMedium?.color,
                fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                Get.offAll(() => Login());
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 25),
                child: Text(
                  "Hủy",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
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
                  height: 20,
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
                        text: widget.emailRegister,
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
                    setState(() {
                      inputOTPController.otp.value = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Obx(
                    () {
                      // Truy xuất HandleOtp bằng Get.find()
                      return (inputOTPController.start.value == 0)
                          ? TextButton(
                              onPressed: () async {},
                              child: const Text(
                                'Gửi lại mã',
                                style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Text(
                              '${inputOTPController.start.value}' 's',
                              style: const TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontSize: 16,
                              ),
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ButtonNext(
            onTap: () async {
              if (inputOTPController.otp.value.isEmpty) {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Cánh báo!',
                    message: 'Bạn chưa nhập mã otp! Vui lòng nhập mã otp',
                    contentType: ContentType.help,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                VerifyOtpRequest request = VerifyOtpRequest(
                  widget.emailRegister,
                  inputOTPController.otp.value,
                );
                inputOTPController.verifyOTPForRegister(
                  request,
                );
              }
            },
            textInside: "Xác nhận OTP",
          ),
        ),
      ),
    );
  }
}
