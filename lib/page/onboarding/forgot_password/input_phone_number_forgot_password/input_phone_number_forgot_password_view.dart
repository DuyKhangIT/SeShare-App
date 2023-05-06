import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/util/module.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../models/register_response/check_existing_phone_number/check_phone_number_request.dart';
import '../../../../util/global.dart';
import 'input_phone_number_forgot_password_controller.dart';

class InputPhoneNumberForgotPassword extends StatefulWidget {
  const InputPhoneNumberForgotPassword({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<InputPhoneNumberForgotPassword> createState() =>
      _InputPhoneNumberForgotPasswordState();
}

class _InputPhoneNumberForgotPasswordState
    extends State<InputPhoneNumberForgotPassword> {
  @override
  Widget build(BuildContext context) {
    InputPhoneNumberForgotPasswordController controller =
        Get.put(InputPhoneNumberForgotPasswordController());
    return GetBuilder<InputPhoneNumberForgotPasswordController>(
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
                      "Bạn cần nhập số điện thoại để chúng tôi có thể gửi mã otp cho bạn!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              "+84",
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: VerticalDivider(
                              width: 10,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                    controller:
                                        controller.phoneForgotPasswordController,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.grey,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                    ],
                                    decoration: InputDecoration(
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
                                      suffixIcon: (controller
                                              .phoneForgotPasswordController
                                              .text
                                              .isEmpty)
                                          ? const SizedBox()
                                          : removeZeroAtFirstDigitPhoneNumber(controller.phoneForgotPasswordController
                                          .text).length <
                                                  9
                                              ? GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .clearTextInputPhoneNumber();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    child: Image.asset(
                                                      IconsAssets.icClearText,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 8),
                                                  child: Image.asset(
                                                      IconsAssets.icChecked),
                                                ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        controller.phoneForgotPassword.value = value;
                                        Global.phoneNumberForgotPassword = controller.phoneForgotPassword.value;
                                        controller.update();
                                      });
                                    }),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Button Next
                    ButtonNext(
                      onTap: () async {
                        if (controller.phoneForgotPassword.value.isEmpty) {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Lỗi!',
                              message: 'Bạn chưa nhập số điện thoại!',
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          CheckPhoneNumberRequest? checkPhoneNumberRequest =
                          CheckPhoneNumberRequest(
                              removeZeroAtFirstDigitPhoneNumber(controller.phoneForgotPassword.value));
                          controller.checkPhoneExistingForgotPassword(checkPhoneNumberRequest);
                        }
                      },
                      textInside: "Gửi mã",
                    ),
                  ],
                ),
              ),
            ));
  }
}
