import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/onboarding/start_up/start_up_controller.dart';
import 'package:instagram_app/widget/button_next.dart';
import 'package:lottie/lottie.dart';
import '../login/login_view.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen>
    with TickerProviderStateMixin {
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
    return GetBuilder<StartUpController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// logo
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'SeShare',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Nunito Sans',
                        fontStyle: FontStyle.italic),
                  ),
                ),
                welcomeTittle(),
                Lottie.asset(IconsAssets.icSplash,
                    controller: animationController,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    animationController
                      ..duration = composition.duration
                      ..forward();

                    // ..forward().then((value) =>
                    //       Get.to(() => Login())
                    //   );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child:
                  //CircularProgressIndicator(),
                  ButtonNext(
                    onTap: () {
                      Get.to(() => Login());
                    },
                    textInside: "Bắt đầu",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Welcome tittle
  Widget welcomeTittle() {
    return Padding(
      padding: const EdgeInsets.only(top: 100,bottom: 40),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CHÀO MỪNG BẠN ĐẾN VỚI \nMẠNG XÃ HỘI HÌNH ẢNH',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                  'Nơi bạn có thể chia sẻ và kết bạn với nhau thông qua những bức ảnh tuyệt vời của mình',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 1),
                  maxLines: 3),
            ),
          ],
        ),
      ),
    );
  }
}
