import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../util/module.dart';
import '../input_otp_register/input_otp_view.dart';
import 'input_email_controller.dart';

class InputEmail extends StatefulWidget {
  const InputEmail({Key? key}) : super(key: key);

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    InputEmailController inputEmailController = Get.put(InputEmailController());
    return GetBuilder<InputEmailController>(
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Đăng ký',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                  fontSize: 20,
                ),
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
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            inputEmailController.emailRegisterController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: 'Email của bạn',
                          hintStyle: const TextStyle(
                            fontFamily: 'NunitoSans',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          counterText: '',
                          suffixIcon: (inputEmailController
                                  .emailRegisterController.text.isEmpty)
                              ? const SizedBox()
                              : !checkEmailAddress(inputEmailController
                                      .emailRegisterController.text)
                                  ? GestureDetector(
                                      onTap: () {
                                        inputEmailController
                                            .clearTextInputPhoneNumber();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Image.asset(
                                          IconsAssets.icClearText,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Image.asset(IconsAssets.icChecked),
                                    ),
                        ),
                        onChanged: (value) {
                          inputEmailController.updateEmailInput(value);
                          debugPrint(inputEmailController.emailRegister.value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ButtonNext(
            onTap: () async {
              Get.to(() => InputOTP(
                    emailRegister: inputEmailController.emailRegister.value,
                  ));
              // if (inputPhoneNumberController.phoneRegister.value.isEmpty) {
              //   final snackBar = SnackBar(
              //     elevation: 0,
              //     behavior: SnackBarBehavior.fixed,
              //     backgroundColor: Colors.transparent,
              //     content: AwesomeSnackbarContent(
              //       title: 'Lỗi!',
              //       message: 'Bạn chưa nhập số điện thoại!',
              //       contentType: ContentType.failure,
              //     ),
              //   );
              //   ScaffoldMessenger.of(context)
              //     ..hideCurrentSnackBar()
              //     ..showSnackBar(snackBar);
              // } else {
              //   CheckPhoneNumberRequest? checkPhoneNumberRequest =
              //       CheckPhoneNumberRequest(
              //           removeZeroAtFirstDigitPhoneNumber(inputPhoneNumberController.phoneRegister.value));
              //   inputPhoneNumberController
              //       .checkPhoneExistingForRegister(checkPhoneNumberRequest);
              //   // save phone number to Global
              //   Global.phoneNumber = removeZeroAtFirstDigitPhoneNumber(inputPhoneNumberController.phoneRegister.value);
              // }
            },
            textInside: "Gửi mã",
          ),
        ),
      ),
    );
  }
}
