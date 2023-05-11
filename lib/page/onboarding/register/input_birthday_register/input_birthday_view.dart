import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/register/input_birthday_register/input_birthday_controller.dart';
import 'package:instagram_app/util/module.dart';

import '../../../../util/global.dart';
import '../../../../widget/button_next.dart';
import '../upload_avatar_register/upload_avatar_view.dart';

class InputBirthday extends StatefulWidget {
  const InputBirthday({Key? key}) : super(key: key);

  @override
  State<InputBirthday> createState() => _InputBirthdayState();
}

class _InputBirthdayState extends State<InputBirthday> {
  @override
  Widget build(BuildContext context) {
    InputBirthdayController inputBirthdayController =
        Get.put(InputBirthdayController());
    return GetBuilder<InputBirthdayController>(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Column(
                    children: [
                      const Text('Sinh nhật của bạn ngày nào',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          'Nhập sinh nhật của bạn để chúng tôi có thể chúc mừng vào ngày trọng đại này',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),

                      /// birthday text field
                      //birthdayTextField(inputBirthdayController),
                      birthdayPicker(inputBirthdayController),
                      /// button
                      ButtonNext(
                        onTap: () {
                          if (Global.isAvailableToClick()) {
                            if (inputBirthdayController.birthDay.isNotEmpty) {
                              Global.registerNewBirthday =
                                  inputBirthdayController.birthDay;
                              print(Global.registerNewBirthday);
                              Get.to(() => const UploadAvatarForRegister());
                            }
                          }
                        },
                        textInside: "Tiếp tục".toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  // Widget birthdayTextField(InputBirthdayController inputBirthdayController) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         /// day
  //         Container(
  //           width: 80,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(6),
  //           ),
  //           margin: const EdgeInsets.symmetric(vertical: 20),
  //           child: TextField(
  //             controller: inputBirthdayController.dayController,
  //             keyboardType: TextInputType.number,
  //             autofocus: true,
  //             textAlign: TextAlign.center,
  //             cursorColor: Colors.grey,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(2),
  //             ],
  //             decoration: const InputDecoration(
  //               isDense: true,
  //               hintText: 'Ngày',
  //               hintStyle: TextStyle(
  //                 fontFamily: 'NunitoSans',
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14,
  //               ),
  //               border: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               counterText: '',
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 inputBirthdayController.day.value = value;
  //               });
  //             },
  //             style: const TextStyle(
  //                 color: Colors.black,
  //                 fontFamily: 'NunitoSans',
  //                 fontSize: 14,
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w600,
  //                 height: 1.9),
  //           ),
  //         ),
  //         Container(
  //             width: 15,
  //             margin: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Divider(
  //                 thickness: 1,
  //                 color: Theme.of(context).textTheme.headline6?.color)),
  //
  //         /// month
  //         Container(
  //           width: 80,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(6),
  //           ),
  //           margin: const EdgeInsets.symmetric(vertical: 20),
  //           child: TextField(
  //             controller: inputBirthdayController.monthController,
  //             keyboardType: TextInputType.number,
  //             autofocus: true,
  //             cursorColor: Colors.grey,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(2),
  //             ],
  //             decoration: const InputDecoration(
  //               isDense: true,
  //               hintText: 'Tháng',
  //               hintStyle: TextStyle(
  //                 fontFamily: 'NunitoSans',
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14,
  //               ),
  //               border: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               counterText: '',
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 inputBirthdayController.month.value = value;
  //               });
  //             },
  //             style: const TextStyle(
  //                 color: Colors.black,
  //                 fontFamily: 'NunitoSans',
  //                 fontSize: 14,
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w600,
  //                 height: 1.9),
  //           ),
  //         ),
  //         Container(
  //             width: 15,
  //             margin: const EdgeInsets.symmetric(horizontal: 10),
  //             child: Divider(
  //                 thickness: 1,
  //                 color: Theme.of(context).textTheme.headline6?.color)),
  //
  //         /// year
  //         Container(
  //           width: 90,
  //           height: 50,
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey),
  //             borderRadius: BorderRadius.circular(6),
  //           ),
  //           margin: const EdgeInsets.fromLTRB(0, 20, 10, 20),
  //           child: TextField(
  //             controller: inputBirthdayController.yearController,
  //             keyboardType: TextInputType.number,
  //             autofocus: true,
  //             cursorColor: Colors.grey,
  //             textAlign: TextAlign.center,
  //             inputFormatters: [
  //               LengthLimitingTextInputFormatter(4),
  //             ],
  //             decoration: const InputDecoration(
  //               isDense: true,
  //               hintText: 'Năm',
  //               hintStyle: TextStyle(
  //                 fontFamily: 'NunitoSans',
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w400,
  //                 fontSize: 14,
  //               ),
  //               border: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               counterText: '',
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 inputBirthdayController.year.value = value;
  //               });
  //             },
  //             style: const TextStyle(
  //                 color: Colors.black,
  //                 fontFamily: 'NunitoSans',
  //                 fontSize: 14,
  //                 fontStyle: FontStyle.normal,
  //                 fontWeight: FontWeight.w600,
  //                 height: 1.9),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget birthdayPicker(InputBirthdayController inputBirthdayController){
    DateTime dateTime = DateTime.now();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: CupertinoDatePicker(
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            return setState(() {
              dateTime = dateTime;
              inputBirthdayController.birthDay = formatMMDDYYYY(dateTime.toString());
              inputBirthdayController.update();
            });
          }

      ),
    );
  }
}
