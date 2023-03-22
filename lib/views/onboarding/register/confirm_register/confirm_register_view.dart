import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/views/onboarding/register/confirm_register/confirm_register_controller.dart';

import '../../../../widget/button_next.dart';
import '../../login/login_view.dart';

class ConfirmRegister extends StatefulWidget {
  const ConfirmRegister({Key? key}) : super(key: key);

  @override
  State<ConfirmRegister> createState() => _ConfirmRegisterState();
}

class _ConfirmRegisterState extends State<ConfirmRegister> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmRegisterController>(
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
                    const Text('Xác nhận đăng ký',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'Chào mừng bạn đến với SeShare. Vui lòng bấm tiếp tục để hoàn thành việc đăng ký',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: ButtonNext(
                          onTap: () {
                            Get.to(() => Login());
                          },
                          textInside: 'tiếp tục'.toUpperCase(),
                        ))
                  ],
                ),
              ),
            )));
  }
}
