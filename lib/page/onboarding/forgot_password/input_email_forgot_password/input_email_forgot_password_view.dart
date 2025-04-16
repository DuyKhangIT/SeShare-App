import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/forgot_password/input_otp_forgot_password/input_otp_forgot_password_view.dart';
import 'package:instagram_app/util/module.dart';
import 'package:instagram_app/widget/button_next.dart';
import 'package:instagram_app/widget/custom_text_field.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../util/global.dart';
import 'input_email_forgot_password_controller.dart';

class InputEmailForgotPassword extends StatefulWidget {
  const InputEmailForgotPassword({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<InputEmailForgotPassword> createState() =>
      _InputEmailForgotPasswordState();
}

class _InputEmailForgotPasswordState extends State<InputEmailForgotPassword> {
  @override
  Widget build(BuildContext context) {
    InputEmailForgotPasswordController controller =
        Get.put(InputEmailForgotPasswordController());
    return GetBuilder<InputEmailForgotPasswordController>(
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
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Bạn cần nhập email để chúng tôi có thể gửi mã otp cho bạn!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFiled(
                textEditingController: controller.emailForgotPasswordController,
                hintText: 'Nhập email của bạn',
                suffixIcon: (controller
                        .emailForgotPasswordController.text.isEmpty)
                    ? null
                    : !checkEmailAddress(
                            controller.emailForgotPasswordController.text)
                        ? GestureDetector(
                            onTap: () {
                              controller.clearTextInputEmail();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Image.asset(
                                IconsAssets.icClearText,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                width: 18,
                                height: 18,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Image.asset(
                              IconsAssets.icChecked,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.greenAccent
                                  : null,
                              width: 18,
                              height: 18,
                            ),
                          ),
                onChanged: (value) {
                  setState(() {
                    controller.emailForgotPassword.value = value;
                    controller.update();
                  });
                },
              ),
              const SizedBox(height: 20),

              /// Button Next
              ButtonNext(
                onTap: () async {
                  if (controller.emailForgotPassword.value.isEmpty) {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Lỗi!',
                        message: 'Bạn chưa nhập email!',
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  } else {
                    Get.to(InputOTPForgotPassword(
                      emailForgot: controller.emailForgotPassword.value,
                    ));
                  }
                },
                textInside: "Gửi mã",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
