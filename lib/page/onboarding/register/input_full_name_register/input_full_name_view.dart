import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/onboarding/register/input_birthday_register/input_birthday_view.dart';

import '../../../../util/global.dart';
import '../../../../widget/button_next.dart';
import 'input_full_name_controller.dart';

class InputFullName extends StatefulWidget {
  const InputFullName({Key? key}) : super(key: key);

  @override
  State<InputFullName> createState() => _InputFullNameState();
}

class _InputFullNameState extends State<InputFullName> {
  @override
  Widget build(BuildContext context) {
    InputFullNameController inputFullNameController =
        Get.put(InputFullNameController());
    return GetBuilder<InputFullNameController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Đăng ký',
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                  child: Column(
                    children: [
                      const Text('Tên của bạn là gì',
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          'Nhập tên của bạn để bạn bè có thể dễ dàng tìm thấy bạn',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),

                      /// text field
                      textFieldFullName(inputFullNameController),

                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  child: ButtonNext(
                    onTap: () {
                      if(Global.isAvailableToClick()){
                        if(inputFullNameController.fullName.value.isNotEmpty){
                          Global.registerNewFullName = inputFullNameController.fullName.value;
                          Get.to(() => const InputBirthday());
                        }else{
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Cảnh báo!',
                              message: "Vui lòng nhập tên của bạn",
                              contentType: ContentType.warning,
                            ),
                          );
                          ScaffoldMessenger.of(Get.context!)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      }

                    },
                    textInside: "Tiếp tục".toUpperCase(),
                  ),
                ),
              ),
            ));
  }

  Widget textFieldFullName(InputFullNameController inputFullNameController){
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: TextField(
        controller:
        inputFullNameController.fullNameController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            isDense: true,
            hintText: 'Tên của bạn',
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
            suffixIcon: (inputFullNameController
                .fullNameController.text.isEmpty)
                ? const SizedBox()
                : GestureDetector(
              onTap: () {
                inputFullNameController
                    .clearTextFullName();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12),
                child: Image.asset(
                  IconsAssets.icClearText,
                ),
              ),
            )),
        onChanged: (value) {
          setState(() {
            inputFullNameController.fullName.value = value;
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
    );
  }
}
