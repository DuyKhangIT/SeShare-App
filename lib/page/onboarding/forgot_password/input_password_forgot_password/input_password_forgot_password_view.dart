import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/widget/custom_text_field.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../models/forgot_password/forgot_password_request.dart';
import '../../../../widget/button_next.dart';
import 'input_password_forgot_password_controller.dart';

class InputPasswordForgotPassword extends StatefulWidget {
  final String emil;
  const InputPasswordForgotPassword({
    Key? key,
    required this.emil,
  }) : super(key: key);

  @override
  State<InputPasswordForgotPassword> createState() =>
      _InputPasswordForgotPasswordState();
}

class _InputPasswordForgotPasswordState
    extends State<InputPasswordForgotPassword> {
  InputPasswordForgotPasswordController inputPasswordForgotPasswordController =
      Get.put(InputPasswordForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputPasswordForgotPasswordController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Quên mật khẩu',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color:
                            Theme.of(context).textTheme.headlineMedium?.color,
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
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Column(
                    children: [
                      /// title
                      const Text('Mật khẩu mới của bạn',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),

                      /// description
                      const Text(
                          'Bạn cần nhập mật khẩu mới để chúng tôi có thể duy trì tiếp tài khoản của bạn',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),

                      /// text field
                      textFieldPasswordForgotPassword()
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ButtonNext(
                    onTap: () {
                      if (widget.emil.isNotEmpty &&
                          inputPasswordForgotPasswordController
                              .newPassword.value.isNotEmpty) {
                        ForgotPasswordRequest request = ForgotPasswordRequest(
                          widget.emil,
                          inputPasswordForgotPasswordController
                              .newPasswordController.text,
                        );
                        inputPasswordForgotPasswordController
                            .resetPassword(request);
                      } else {
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Cảnh báo!',
                            message: "Vui lòng nhập đủ thông tin",
                            contentType: ContentType.warning,
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    textInside: "Tiếp tục",
                  ),
                ),
              ),
            ));
  }

  Widget textFieldPasswordForgotPassword() {
    return CustomTextFiled(
      textEditingController:
          inputPasswordForgotPasswordController.newPasswordController,
      hintText: 'Nhập mật khẩu mới của bạn',
      onChanged: (value) {
        setState(() {
          inputPasswordForgotPasswordController.newPassword.value = value;
        });
      },
      suffixIcon: (inputPasswordForgotPasswordController
              .newPasswordController.text.isEmpty)
          ? const SizedBox()
          : inputPasswordForgotPasswordController
                      .newPasswordController.text.length >=
                  6
              ? SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          inputPasswordForgotPasswordController
                                  .isShowPassword.value =
                              !inputPasswordForgotPasswordController
                                  .isShowPassword.value;
                          inputPasswordForgotPasswordController.update();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Obx(
                            () => inputPasswordForgotPasswordController
                                        .isShowPassword.value ==
                                    true
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Image.asset(
                          IconsAssets.icChecked,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.greenAccent
                              : null,
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    inputPasswordForgotPasswordController.isShowPassword.value =
                        !inputPasswordForgotPasswordController
                            .isShowPassword.value;
                    inputPasswordForgotPasswordController.update();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Obx(
                      () => inputPasswordForgotPasswordController
                                  .isShowPassword.value ==
                              true
                          ? Icon(
                              Icons.visibility,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            )
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
    );
  }
}
