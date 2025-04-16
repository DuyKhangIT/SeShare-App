import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/login/user_request.dart';
import 'package:instagram_app/util/module.dart';
import 'package:instagram_app/widget/button_next.dart';
import 'package:instagram_app/widget/custom_text_field.dart';

import '../../../assets/icons_assets.dart';
import '../../../config/share_preferences.dart';
import '../../../util/global.dart';
import '../../navigation_bar/navigation_bar_view.dart';
import '../forgot_password/input_email_forgot_password/input_email_forgot_password_view.dart';
import '../register/input_email_register/input_email_view.dart';
import 'login_controller.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// logo
                  const Text(
                    'SeShare',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Nunito Sans',
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  formLogin(loginController),
                  const SizedBox(height: 40),
                  ButtonNext(
                      onTap: () {
                        Get.offAll(() => NavigationBarView(currentIndex: 0));
                        // if(Global.isAvailableToClick()){
                        //   if (loginController.phoneLogin.isNotEmpty &&
                        //       loginController.passwordLogin.isNotEmpty) {
                        //     UserRequest? userRequest = UserRequest(
                        //         removeZeroAtFirstDigitPhoneNumber(
                        //             loginController.phoneLogin),
                        //         removeZeroAtFirstDigitPhoneNumber(
                        //             loginController.passwordLogin));
                        //     loginController.authenticate(userRequest);
                        //   }
                        // }
                      },
                      textInside: "Đăng nhập"),
                  const SizedBox(height: 50),

                  /// divider
                  customDivider(),
                  const SizedBox(height: 50),

                  /// register
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Bạn không có tải khoản?',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)),
                        const TextSpan(text: " "),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const InputEmail());
                            },
                          text: 'Đăng ký.',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontStyle: FontStyle.italic,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// form login
  Widget formLogin(LoginController loginController) {
    loginController = Get.put(LoginController());
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          /// text field email login
          CustomTextFiled(
            textEditingController: loginController.emailLoginController,
            title: 'Email',
            hintText: 'Nhập email của bạn',
            isRequired: false,
            textInputType: TextInputType.emailAddress,
            inputFormatters: [
              LengthLimitingTextInputFormatter(12),
            ],
            onChanged: (value) {
              setState(() {
                loginController.emailLogin = value;
                loginController.update();
              });
            },
            suffixIcon: (loginController.emailLoginController.text.isEmpty)
                ? null
                : !checkEmailAddress(loginController.emailLoginController.text)
                    ? GestureDetector(
                        onTap: () {
                          loginController.clearTextPhoneLogin();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Image.asset(IconsAssets.icClearText,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Image.asset(
                          IconsAssets.icChecked,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.greenAccent
                              : null,
                        ),
                      ),
          ),

          /// text field password login
          CustomTextFiled(
            obscureText: !loginController.isShowPassword.value,
            textEditingController: loginController.passwordLoginController,
            title: 'Mật khẩu',
            hintText: 'Nhập mật khẩu của bạn',
            isRequired: false,
            textInputType: TextInputType.visiblePassword,
            inputFormatters: [
              LengthLimitingTextInputFormatter(12),
            ],
            onChanged: (value) {
              setState(() {
                loginController.passwordLogin = value;
                loginController.update();
              });
            },
            suffixIcon: (loginController.passwordLoginController.text.isEmpty)
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      loginController.isShowPassword.value =
                          !loginController.isShowPassword.value;
                      loginController.update();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Obx(
                        () => loginController.isShowPassword.value == true
                            ? Icon(Icons.visibility,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                            : Icon(
                                Icons.visibility_off,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                      ),
                    ),
                  ),
          ),

          /// forgot password
          GestureDetector(
            onTap: () {
              Get.to(() => const InputEmailForgotPassword());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.centerRight,
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// divider
  Widget customDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Divider(
              thickness: 0.5,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        Text(
          'Hoặc'.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Divider(
              thickness: 0.5,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
