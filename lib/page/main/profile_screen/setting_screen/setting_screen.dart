import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/change_password/change_password_screen.dart';
import 'package:instagram_app/page/main/profile_screen/setting_screen/setting_controller.dart';

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
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      color: Theme.of(context).textTheme.headline6?.color),
                ),
                title: Text("Cài đặt",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline6?.color,
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
                    InkWell(
                      onTap: (){
                        Get.to(() => const ChangePasswordScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            IconsAssets.icSecurity,
                            color: Theme.of(context).textTheme.headline6?.color,
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
                          color: Theme.of(context).textTheme.headline6?.color,
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
                    InkWell(
                      onTap: () {
                        ThemeService().changeTheme();
                      },
                      splashColor: Colors.transparent,
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
                          const Text(
                            "Chế độ tối",
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
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 30,
                      child: const Text(
                          "Trung tâm tài khoản",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      child: Text(
                          "Kiểm soát chế độ cài đặt khi kết nối các trải nghiệm trên SeShare, bao gồm tính năng chia sẻ tin, bài viết, đăng nhập.",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 14,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black.withOpacity(0.6),
                          )),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {},
                      child: Text("Thêm tài khoản",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme.headline6?.color,
                          )),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        ConfigSharedPreferences()
                            .setStringValue(SharedData.TOKEN.toString(), "");
                        Get.offAll(() => Login());
                      },
                      child: Text("Đăng xuất",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 16,
                            color: Theme.of(context).textTheme.headline6?.color,
                          )),
                    ),
                  ],
                ),
              )),
            ));
  }
}
