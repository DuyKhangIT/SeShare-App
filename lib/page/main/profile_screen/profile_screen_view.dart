import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/profile_controller.dart';
import 'package:instagram_app/widget/avatar_circle.dart';

import '../../../config/theme_service.dart';
import '../../navigation_bar/navigation_bar_view.dart';
import '../../onboarding/login/login_view.dart';

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
        builder: (controller) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Duy Khang',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  /// menu
                  GestureDetector(
                    onTap: () {},
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(IconsAssets.icMenuSetting),
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarCircle(image: ImageAssets.imgTet),
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
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20, 20, 60, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Duy Khang",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans')),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Một người sáng tạo, đầy hoài bảo",
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans')),
                      ],
                    ),
                  ),

                  /// button edit profile
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2))),
                    child: const Text("Chỉnh sửa trang cá nhân",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Nunito Sans')),
                  ),
                  SizedBox(height: 120, child: listViewStory()),
                  Divider(
                    color: Colors.black.withOpacity(0.4),
                    height: 1,
                  ),
                  Expanded(child: tabProfile())
                ],
              ),
            ));
  }

  /// list view story
  Widget listViewStory() {
    ProfileController profileController = Get.put(ProfileController());
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4, //Call API
          itemBuilder: (context, index) {
            return contentListViewStory();
          }),
    );
  }

  /// content list view story
  Widget contentListViewStory() {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarCircle(
              onTap: () {
                //Get.to(() => const StoryPage());
              },
              image: ImageAssets.imgTet),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Bạn bè",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
          ),
        ],
      ),
    );
  }

  /// tab profile
  Widget tabProfile() {
    ProfileController profileController = Get.put(ProfileController());
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10),
          child: DefaultTabController(
              length: 2,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: (85)),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
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
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icGridView))),
                  Tab(
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icProfilePerson))),
                ],
              )),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // girdview
              Tab1(tabController: profileController),

              /// tag person
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
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 12,
            itemBuilder: (context, index) => contentGridView()));
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
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 2,
            itemBuilder: (context, index) => contentGridView()));
  }

  /// content gridview
  Widget contentGridView() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRect(
        child: Image.asset(ImageAssets.imgTest, fit: BoxFit.cover),
      ),
    );
  }
}
