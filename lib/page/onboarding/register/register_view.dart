import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/register/confirm_register/confirm_register_view.dart';
import 'package:instagram_app/page/onboarding/register/register_controller.dart';

import '../../../assets/icons_assets.dart';
import '../../../util/module.dart';
import '../../../widget/button_next.dart';
import '../../../widget/custom_text_field.dart';
import '../login/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
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
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                Get.offAll(() => Login());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Hủy',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.color,
                              fontSize: 16)),
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                (registerController.avatar != null)
                    ? GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return detailBottomSheet();
                              });
                        },
                        child: Stack(
                          children: [
                            Container(
                                width: 160,
                                height: 160,
                                margin: const EdgeInsets.only(top: 80),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.file(
                                    registerController.avatar!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Positioned(
                              right: 10,
                              bottom: 10,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset(IconsAssets.icPen,
                                        height: 16, width: 16)),
                              ),
                            )
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return detailBottomSheet();
                              });
                        },
                        child: Container(
                            width: 160,
                            height: 160,
                            margin: const EdgeInsets.only(top: 100),
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: DottedBorder(
                                color: Colors.black.withOpacity(0.5),
                                strokeWidth: 1,
                                borderType: BorderType.Circle,
                                dashPattern: const [6, 5],
                                radius: const Radius.circular(60),
                                child: Center(
                                    child: Image.asset(IconsAssets.icUpload)))),
                      ),
                const SizedBox(height: 12),
                const Text(
                  'Ảnh đại diện',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Nunito Sans',
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // full name
                CustomTextFiled(
                  title: 'Họ & Tên',
                  hintText: 'Nhập họ tên của bạn',
                  textEditingController: registerController.fullNameController,
                  onChanged: (value) {
                    setState(() {
                      registerController.fullName.value = value;
                    });
                  },
                  suffixIcon: (registerController
                          .fullNameController.text.isEmpty)
                      ? null
                      : GestureDetector(
                          onTap: () {
                            registerController.clearTextFullName();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Image.asset(
                              IconsAssets.icClearText,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                ),
                // password
                CustomTextFiled(
                  obscureText: !registerController.isShowPassword.value,
                  title: 'Mật khẩu (6 - 12 kí tự)',
                  hintText: 'Nhập mật khẩu của bạn',
                  textEditingController: registerController.passwordController,
                  inputFormatters: [LengthLimitingTextInputFormatter(12)],
                  onChanged: (value) {
                    setState(() {
                      registerController.password.value = value;
                    });
                  },
                  suffixIcon: (registerController
                          .passwordController.text.isEmpty)
                      ? null
                      : registerController.passwordController.text.length >= 6
                          ? SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      registerController.isShowPassword.value =
                                          !registerController
                                              .isShowPassword.value;
                                      registerController.update();
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Obx(() => registerController
                                                    .isShowPassword.value ==
                                                true
                                            ? const Icon(Icons.visibility,
                                                color: Colors.black)
                                            : const Icon(Icons.visibility_off,
                                                color: Colors.black))),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    child: Image.asset(
                                      IconsAssets.icChecked,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                registerController.isShowPassword.value =
                                    !registerController.isShowPassword.value;
                                registerController.update();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Obx(
                                  () =>
                                      registerController.isShowPassword.value ==
                                              true
                                          ? const Icon(
                                              Icons.visibility,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                ),
                              ),
                            ),
                ),
                // confirm password
                CustomTextFiled(
                  obscureText: !registerController.isConfirmShowPassword.value,
                  title: 'Xác nhận mật khẩu (6 - 12 kí tự)',
                  hintText: 'Nhập lại mật khẩu của bạn',
                  textEditingController:
                      registerController.confirmPasswordController,
                  inputFormatters: [LengthLimitingTextInputFormatter(12)],
                  onChanged: (value) {
                    setState(() {
                      registerController.confirmPassword.value = value;
                    });
                  },
                  suffixIcon: (registerController
                          .confirmPasswordController.text.isEmpty)
                      ? null
                      : registerController
                                  .confirmPasswordController.text.length >=
                              6
                          ? SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      registerController
                                              .isConfirmShowPassword.value =
                                          !registerController
                                              .isConfirmShowPassword.value;
                                      registerController.update();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Obx(
                                        () => registerController
                                                    .isConfirmShowPassword
                                                    .value ==
                                                true
                                            ? const Icon(Icons.visibility,
                                                color: Colors.black)
                                            : const Icon(Icons.visibility_off,
                                                color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    child: Image.asset(
                                      IconsAssets.icChecked,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                registerController.isConfirmShowPassword.value =
                                    !registerController
                                        .isConfirmShowPassword.value;
                                registerController.update();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Obx(
                                  () => registerController
                                              .isConfirmShowPassword.value ==
                                          true
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                ),
                              ),
                            ),
                ),
                // birthday
                birthdayPicker(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ButtonNext(
            onTap: () {
              // confirmRegisterController.signUp();
              Get.to(const ConfirmRegister());
            },
            textInside: 'đăng ký'.toUpperCase(),
          ),
        ),
      ),
    );
  }

  Widget detailBottomSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    registerController.getImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: const TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),
              GestureDetector(
                  onTap: () {
                    registerController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Chọn ảnh từ thư viện".toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: const EdgeInsets.only(
              bottom: 34,
              left: 34,
              right: 34,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy".toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Widget birthdayPicker() {
    DateTime dateTime = DateTime.now();
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chọn ngày sinh của bạn',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 150,
            child: CupertinoDatePicker(
              maximumYear: DateTime.now().year,
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dateTime) {
                return setState(
                  () {
                    dateTime = dateTime;
                    registerController.birthDay =
                        formatMMDDYYYY(dateTime.toString());
                    registerController.update();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
