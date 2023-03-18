import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/views/onboarding/forgot_password/input_phone_number_for_forgot_password.dart';
import 'package:instagram_app/views/onboarding/register/input_phone_number.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../assets/icons_assets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneLoginController = TextEditingController();
  String phoneLogin = "";
  TextEditingController passwordLoginController = TextEditingController();
  String passwordLogin = "";
  void clearTextPhoneLogin() {
    setState(() {
      phoneLoginController.clear();
      phoneLogin = "";
    });
  }

  void clearTextPasswordLogin() {
    setState(() {
      passwordLoginController.clear();
      passwordLogin = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 150),

            /// logo
            const Align(
              alignment: Alignment.center,
              child: Text(
                'SeShare',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Nunito Sans',
                    fontStyle: FontStyle.italic),
              ),
            ),

            formLogin(),
            const SizedBox(height: 40),
            ButtonNext(onTap: () {}, textInside: "Đăng nhập"),
            const SizedBox(height: 50),

            /// divider
            customDivider(),
            const SizedBox(height: 50),

            /// register
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'Bạn không có tải khoản?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      color: Colors.black)),
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
    ));
  }

  Widget formLogin() {
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
              controller: phoneLoginController,
              keyboardType: TextInputType.number,
              autofocus: true,
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
                suffixIcon: (phoneLoginController.text.isEmpty)
                    ? const SizedBox()
                    : phoneLoginController.text.length < 10
                        ? GestureDetector(
                            onTap: () {
                              clearTextPhoneLogin();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Image.asset(
                                IconsAssets.icClearText,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Image.asset(IconsAssets.icChecked),
                          ),
              ),
              onChanged: (value) {
                setState(() {
                  phoneLogin = value;
                });
              },
              style: const TextStyle(
                  color: Colors.black,
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
              controller: passwordLoginController,
              keyboardType: TextInputType.text,
              autofocus: true,
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
                  suffixIcon: (passwordLoginController.text.isEmpty)
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            clearTextPasswordLogin();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Image.asset(
                              IconsAssets.icClearText,
                            ),
                          ),
                        )),
              onChanged: (value) {
                setState(() {
                  passwordLogin = value;
                });
              },
              style: const TextStyle(
                  color: Colors.black,
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
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: Divider(thickness: 0.5),
          ),
        ),
        Text(
          'or'.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Divider(thickness: 0.5),
          ),
        ),
      ],
    );
  }
}
