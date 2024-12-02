import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/login/user_request.dart';
import 'package:instagram_app/util/module.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../assets/icons_assets.dart';
import '../../../config/share_preferences.dart';
import '../../../util/global.dart';
import '../../navigation_bar/navigation_bar_view.dart';
import '../forgot_password/input_phone_number_forgot_password/input_phone_number_forgot_password_view.dart';
import '../register/input_phone_number_register/input_phone_number_view.dart';
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
        builder: (controller) => SafeArea(
                child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// logo
                    const Text(
                      'SeShare',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Nunito Sans',
                          fontStyle: FontStyle.italic),
                    ),

                    formLogin(loginController),
                    const SizedBox(height: 40),
                    ButtonNext(
                        onTap: () {
                          Get.offAll(() =>  NavigationBarView(currentIndex: 0));
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
                        text: TextSpan(children: [
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
                              Get.to(() => const InputPhoneNumber());
                            },
                          text: 'Đăng ký.',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontStyle: FontStyle.italic,
                              color: Colors.blue))
                    ]))
                  ],
                ),
              ),
            )));
  }

  /// form login
  Widget formLogin(LoginController loginController) {
    loginController = Get.put(LoginController());
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          /// text field phone login
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: TextField(
              controller: loginController.phoneLoginController,
              keyboardType: TextInputType.phone,
              cursorColor: Colors.grey,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
              ],
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Số điện thoại của bạn',
                hintStyle: const TextStyle(
                  fontFamily: 'NunitoSans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                counterText: '',
                suffixIcon: (loginController.phoneLoginController.text.isEmpty)
                    ? const SizedBox()
                    : removeZeroAtFirstDigitPhoneNumber(
                                    loginController.phoneLoginController.text)
                                .length <
                            9
                        ? GestureDetector(
                            onTap: () {
                              loginController.clearTextPhoneLogin();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Image.asset(
                                IconsAssets.icClearText,color: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Colors.white
                                  : Colors.black
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Image.asset(IconsAssets.icChecked,color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? Colors.greenAccent
                                : null),
                          ),
              ),
              onChanged: (value) {
                setState(() {
                  loginController.phoneLogin = value;
                  loginController.update();
                });
              },
              style: TextStyle(
                  color: Theme.of(context).brightness ==
                      Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'NunitoSans',
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.9),
            ),
          ),

          /// text field password login
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: TextField(
              obscureText: !loginController.isShowPassword.value,
              controller: loginController.passwordLoginController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Mật khẩu của bạn',
                  hintStyle: const TextStyle(
                    fontFamily: 'NunitoSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  counterText: '',
                  suffixIcon: (loginController
                          .passwordLoginController.text.isEmpty)
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            loginController.isShowPassword.value =
                                !loginController.isShowPassword.value;
                            loginController.update();
                          },
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Obx(() => loginController
                                          .isShowPassword.value ==
                                      true
                                  ?  Icon(Icons.visibility, color: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                                  :  Icon(Icons.visibility_off,
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? Colors.white
                                      : Colors.black))),
                        )
              ),
              onChanged: (value) {
                setState(() {
                  loginController.passwordLogin = value;
                  loginController.update();
                });
              },
              style: TextStyle(
                  color: Theme.of(context).brightness ==
                      Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'NunitoSans',
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  height: 1.9),
            ),
          ),

          /// forgot password
          GestureDetector(
            onTap: () {
              Get.to(() => const InputPhoneNumberForgotPassword());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.centerRight,
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700),
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
            child: Divider(thickness: 0.5,color: Theme.of(context).brightness ==
                Brightness.dark
                ? Colors.white
                : Colors.black),
          ),
        ),
        Text(
          'Hoặc'.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'),
        ),
         Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Divider(thickness: 0.5,color: Theme.of(context).brightness ==
                Brightness.dark
                ? Colors.white
                : Colors.black),
          ),
        ),
      ],
    );
  }
}
