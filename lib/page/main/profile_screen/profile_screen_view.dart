import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/profile_controller.dart';
import 'package:instagram_app/widget/avatar_circle.dart';

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
    _tabController = TabController(length: 3, vsync: this);
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                      ),
                      child: Image.asset(ImageAssets.imgTet, fit: BoxFit.cover),
                    ),
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
                                  child: Image.asset(
                                    ImageAssets.imgTet,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text("Duy Khang",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(child: tabProfile())
                        ],
                      ),
                    ),
                    /// menu setting
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 20),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            IconsAssets.icDot,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
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
      height: 70,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarStory(
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
          child: DefaultTabController(
              length: 3,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: (50)),
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
                  Tab(
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icShare))),
                ],
              )),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // girdview of person
              Tab1(tabController: profileController),

              /// tag person
              Tab2(tabController: profileController),

              /// story
              Tab3(tabController: profileController),
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

class Tab3 extends StatefulWidget {
  final ProfileController tabController;
  const Tab3({Key? key, required this.tabController}) : super(key: key);

  @override
  _Tab3 createState() => _Tab3();
}

class _Tab3 extends State<Tab3> with AutomaticKeepAliveClientMixin<Tab3> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 5,
            itemBuilder: (context, index) => contentGridView()));
  }

  /// content gridview
  Widget contentGridView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Image.asset(ImageAssets.imgTest, fit: BoxFit.cover),
      ),
    );
  }
}
