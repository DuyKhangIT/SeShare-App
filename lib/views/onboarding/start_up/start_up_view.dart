import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/views/onboarding/start_up/start_up_controller.dart';
import 'package:instagram_app/widget/button_next.dart';
import '../login/login_view.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
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
                welcomeTittle()
                // (auth.currentUser == null)
                //     ? welcomeTittle()
                //     : imgAndUserName(auth),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: ButtonNext(
              onTap: () {
                Get.to(() => Login());
              },
              textInside: "Bắt đầu",
            ),
          ),
        ),
      ),
    );
  }

  /// image and user name
  Widget imgAndUserName() {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 85,
              height: 85,
              margin: const EdgeInsets.only(top: 52),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: const ClipOval(child: Icon(Icons.person))),
          const SizedBox(height: 13),
          Text(
           "user",
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Welcome tittle
  Widget welcomeTittle() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
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
