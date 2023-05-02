import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/profile_controller.dart';
import 'package:instagram_app/page/main/profile_screen/update_profile_screen/update_profile_screen_view.dart';
import 'package:instagram_app/page/onboarding/login/login_view.dart';

import '../../../config/share_preferences.dart';
import '../../../util/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return GetBuilder<ProfileController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    /// ảnh bìa
                    Image.asset(
                      ImageAssets.imgTet,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                    ),

                    /// name and status // tab
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                width: 80,
                                height: 80,
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Global.userProfileResponse!.avatarPath!
                                          .isNotEmpty
                                      ? Image.network(
                                          Global.convertMedia(Global
                                              .userProfileResponse!
                                              .avatarPath!),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                )),
                          ),

                          /// full name
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(Global.userProfileResponse!.fullName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Nunito Sans')),
                                const SizedBox(
                                  height: 5,
                                ),
                                Global.userProfileResponse!.bio!.isNotEmpty
                                    ? Text(Global.userProfileResponse!.bio!,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            fontFamily: 'Nunito Sans'))
                                    : Container(),
                              ],
                            ),
                          ),

                          /// number of post
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: const [
                                  Text("54",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                  Text("Bài đăng",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                ],
                              ),
                              Column(
                                children: const [
                                  Text("100",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                  Text("Người theo dõi",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                ],
                              ),
                              Column(
                                children: const [
                                  Text("200",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                  Text("Đang theo dõi",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans')),
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const UpdateProfileScreen());
                                  },
                                  child: Container(
                                    height: 30,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Text(
                                      "Chỉnh sửa trang cá nhân",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    "Chia sẻ trang cá nhân",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: tabProfile())
                        ],
                      ),
                    ),

                    /// menu setting
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          ConfigSharedPreferences()
                              .setStringValue(SharedData.TOKEN.toString(), "");
                          Get.offAll(() => Login());
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(top: 20, right: 20),
                          child: Image.asset(
                            IconsAssets.icDot,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  /// tab profile
  Widget tabProfile() {
    ProfileController profileController = Get.put(ProfileController());
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: DefaultTabController(
              length: 2,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: (60)),
                labelColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                unselectedLabelColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                labelStyle: const TextStyle(
                  fontSize: (13),
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: (13),
                  fontWeight: FontWeight.w400,
                ),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                tabs: [
                  Tab(
                      child: Column(
                    children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icGridView)),
                      const SizedBox(height: 5),
                      const Text("Ảnh của bạn",
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Nunito Sans'))
                    ],
                  )),
                  Tab(
                      child: Column(
                    children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icShare)),
                      const SizedBox(height: 5),
                      const Text("Story của bạn",
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'Nunito Sans'))
                    ],
                  )),
                ],
              )),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // girdview of person
              Tab1(tabController: profileController),

              /// story
              Tab2(tabController: profileController),
            ],
          ),
        ),
      ],
    );
  }
}

class Tab1 extends StatefulWidget {
  final ProfileController tabController;
  const Tab1({Key? key, required this.tabController}) : super(key: key);

  @override
  _Tab1 createState() => _Tab1();
}

class _Tab1 extends State<Tab1> with AutomaticKeepAliveClientMixin<Tab1> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Global.userProfileResponse!.photo!.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.only(bottom: 75),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: Global.userProfileResponse!.photo!.length,
            itemBuilder: (context, index) => contentGridView(index))
        : const Center(
            child: Text(
            "Không có ảnh nào trong album của bạn",
            style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'),
          ));
  }

  /// content gridview
  Widget contentGridView(index) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRect(
          child: Image.network(
              Global.convertMedia(Global.userProfileResponse!.photo![index]),
              fit: BoxFit.cover),
        ));
  }
}

class Tab2 extends StatefulWidget {
  final ProfileController tabController;
  const Tab2({Key? key, required this.tabController}) : super(key: key);

  @override
  _Tab2 createState() => _Tab2();
}

class _Tab2 extends State<Tab2> with AutomaticKeepAliveClientMixin<Tab2> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
        padding: const EdgeInsets.only(bottom: 75),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 5,
        itemBuilder: (context, index) => contentGridView());
  }

  /// content gridview
  Widget contentGridView() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRect(
        child: Image.asset(ImageAssets.imgTet, fit: BoxFit.cover),
      ),
    );
  }
}
