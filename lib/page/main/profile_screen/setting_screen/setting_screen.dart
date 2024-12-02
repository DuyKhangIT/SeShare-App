import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/home_screen/infor_account_screen/infro_account_view.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/change_password/change_password_screen.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_controller.dart';
import 'package:instagram_app/page/onboarding/register/input_phone_number_register/input_phone_number_view.dart';
import 'package:instagram_app/widget/button_next.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../config/share_preferences.dart';
import '../../../../config/theme_service.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import '../../../onboarding/login/login_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.put(SettingController());
    return GetBuilder<SettingController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.to(() => NavigationBarView(currentIndex: 4));
                  },
                  child: Icon(Icons.arrow_back,
                      color: Theme.of(context).textTheme.headlineMedium?.color),
                ),
                title: Text("Cài đặt",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headlineMedium?.color,
                    )),
                elevation: 0,
              ),
              body: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// security
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ChangePasswordScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            IconsAssets.icSecurity,
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Bảo mật",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          IconsAssets.icInfoApp,
                          color: Theme.of(context).textTheme.headlineMedium?.color,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Giới thiệu",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    /// light mode or dark mode
                    GestureDetector(
                      onTap: () {
                        ThemeService().changeTheme();
                        settingController.isClick = !settingController.isClick;
                        settingController.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              BlendMode.srcIn,
                            ),
                            child: const Icon(
                              moonIcon,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            settingController.isClick
                                ? "Chế độ sáng"
                                : "Chế độ tối",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    /// light mode or dark mode
                    GestureDetector(
                      onTap: () {
                        Get.to(() => InForAccountScreen(isMyAccount: true));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              BlendMode.srcIn,
                            ),
                            child: const Icon(
                              Icons.account_circle_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Giới thiệu tài khoản",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 30,
                      child: const Text("Trung tâm tài khoản",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      child: Text(
                          "Kiểm soát chế độ cài đặt khi kết nối các trải nghiệm trên SeShare, bao gồm tính năng chia sẻ tin, bài viết, đăng nhập.",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 14,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.6),
                          )),
                    ),
                    const SizedBox(height: 30),

                    /// adding account
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return detailBottomSheetMenu();
                            });
                      },
                      child: Text("Thêm tài khoản",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                          )),
                    ),
                    const SizedBox(height: 30),

                    /// logout
                    GestureDetector(
                      onTap: () {
                        /// dialog logout
                        Get.defaultDialog(
                            backgroundColor: Colors.white,
                            titleStyle: const TextStyle(
                                color: Colors.black, fontFamily: 'Nunito Sans'),
                            title: "Đăng xuất",
                            barrierDismissible: false,
                            cancel: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 70,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue,style: BorderStyle.solid)),
                                child: const Text("Hủy",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito Sans')),
                              ),
                            ),
                            confirm: GestureDetector(
                              onTap: (){
                                ConfigSharedPreferences().setStringValue(
                                    SharedData.TOKEN.toString(), "");
                                Get.offAll(() => Login());
                              },
                              child: Container(
                                width: 80,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue,style: BorderStyle.solid)),
                                child: const Text("Xác nhận",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito Sans')),
                              ),
                            ),
                            radius: 12,
                            content: const Text(
                                "Bạn có chắc là muốn đăng xuất không?",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Nunito Sans')));
                      },
                      child: Text("Đăng xuất",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                          )),
                    ),
                  ],
                ),
              )),
            ));
  }

  Widget detailBottomSheetMenu() {
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
            height: 180,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Thêm tài khoản",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito Sans',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(),
                ),
                ButtonNext(
                  onTap: () {
                    ConfigSharedPreferences()
                        .setStringValue(SharedData.TOKEN.toString(), "");
                    Get.offAll(() => Login());
                  },
                  textInside: "Đăng nhập với tài khoản hiện có",
                ),
                GestureDetector(
                  onTap: () {
                    ConfigSharedPreferences()
                        .setStringValue(SharedData.TOKEN.toString(), "");
                    Get.offAll(() => const InputPhoneNumber());
                  },
                  child: const Text(
                    "Tạo tài khoản mới",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito Sans',
                        color: Colors.black),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
