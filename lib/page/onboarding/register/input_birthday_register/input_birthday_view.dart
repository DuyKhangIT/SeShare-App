import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).brightness ==
                            Brightness.dark
                            ? Colors.white
                            : Colors.black
                    ),
                  ),
                  elevation: 0,
                ),
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Column(
                    children: [
                      const Text('Sinh nhật của bạn ngày nào',
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
                          'Nhập sinh nhật của bạn để chúng tôi có thể chúc mừng vào ngày trọng đại này',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),

                      /// birthday text field
                      birthdayPicker(inputBirthdayController),

                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  child: ButtonNext(
                    onTap: () {
                      if (Global.isAvailableToClick()) {
                        if (inputBirthdayController.birthDay.isNotEmpty) {
                          Global.registerNewBirthday =
                              inputBirthdayController.birthDay;
                          debugPrint(Global.registerNewBirthday);
                          Get.to(() => const UploadAvatarForRegister());
                        }
                      }
                    },
                    textInside: "Tiếp tục".toUpperCase(),
                  ),
                ),
              ),
            ));
  }

  Widget birthdayPicker(InputBirthdayController inputBirthdayController){
    DateTime dateTime = DateTime.now();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: const EdgeInsets.only(top: 30),
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
