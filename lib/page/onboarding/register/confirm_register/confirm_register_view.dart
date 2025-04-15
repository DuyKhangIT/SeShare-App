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
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                    fontSize: 20,
                  ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Xác nhận đăng ký ",
                        ),
                        TextSpan(
                          text: "Thành Công",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(
                          text: "!",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Chào mừng bạn đến với SeShare\n Vui lòng bấm "Ok" để hoàn thành việc đăng ký.',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 80,
                  ),
                  Lottie.asset(
                    AnimationAssets.icConfirm,
                    controller: animationController,
                    repeat: true,
                    onLoaded: (composition) {
                      animationController
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: ButtonNext(
              onTap: () {
                Get.to(Login());
              },
              textInside: 'Ok'.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
