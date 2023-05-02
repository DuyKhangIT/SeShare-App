import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/animation_assets.dart';
import 'package:lottie/lottie.dart';

import '../../../../widget/button_next.dart';
import '../../login/login_view.dart';
import 'confirm_register_controller.dart';

class ConfirmRegister extends StatefulWidget {
  const ConfirmRegister({Key? key}) : super(key: key);

  @override
  State<ConfirmRegister> createState() => _ConfirmRegisterState();
}

class _ConfirmRegisterState extends State<ConfirmRegister>
    with TickerProviderStateMixin {
  ConfirmRegisterController confirmRegisterController =
      Get.put(ConfirmRegisterController());
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                actions: [
                  GestureDetector(
                    onTap: (){
                      Get.offAll(() => Login());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Hủy',
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).textTheme.headline6?.color,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ],
                elevation: 0,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                          'Chào mừng bạn đến với SeShare\n Vui lòng bấm tiếp tục để hoàn thành việc đăng ký.',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),
                      Lottie.asset(
                        AnimationAssets.icConfirm,
                        controller: animationController,
                        reverse: true,
                        repeat: true,
                        onLoaded: (composition) {
                          animationController
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80),
                          child: ButtonNext(
                            onTap: () {
                              confirmRegisterController.signUp();
                            },
                            textInside: 'tiếp tục'.toUpperCase(),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
