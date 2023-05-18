import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/another_profile_screen/another_profile_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/global.dart';
import '../../../util/module.dart';

class AnOtherProfileScreen extends StatefulWidget {
  const AnOtherProfileScreen({Key? key}) : super(key: key);

  @override
  State<AnOtherProfileScreen> createState() => _AnOtherProfileScreenState();
}

class _AnOtherProfileScreenState extends State<AnOtherProfileScreen>
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
    AnOtherProfileController anOtherProfileController =
        Get.put(AnOtherProfileController());
    return GetBuilder<AnOtherProfileController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(bottom: 60),
                    child: Stack(
                      children: [
                        /// ảnh bìa
                        anOtherProfileController.background.isNotEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                child: getNetworkImage(
                                    anOtherProfileController.background,
                                    width: 400,
                                    height: 180))
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                color: Colors.grey.withOpacity(0.4),
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
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 5),
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: anOtherProfileController
                                                .avatar.isNotEmpty
                                            ? getNetworkImage(
                                                anOtherProfileController.avatar,
                                                width: 80,
                                                height: 80)
                                            : Container())),
                              ),

                              /// full name
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    anOtherProfileController.fullName.isNotEmpty
                                        ? Text(
                                            anOtherProfileController.fullName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: 'Nunito Sans'))
                                        : Container(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    anOtherProfileController.bio.isNotEmpty
                                        ? Text(anOtherProfileController.bio,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      Text("Bạn bè",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 6, 10, 6),
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(IconsAssets.icAddFriend,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                            const SizedBox(width: 6),
                                            const Text(
                                              "Thêm bạn",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito Sans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //
                                    //   },
                                    //   child: Container(
                                    //     height: 30,
                                    //     padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                    //     margin: const EdgeInsets.only(right: 20),
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.grey.withOpacity(0.4),
                                    //         borderRadius: BorderRadius.circular(8)),
                                    //     child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.start,
                                    //       children: [
                                    //         Image.asset(IconsAssets.icAcceptFriend),
                                    //         const SizedBox(width: 6),
                                    //         const Text(
                                    //           "Bạn bè",
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               fontFamily: 'Nunito Sans',
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //
                                    //   },
                                    //   child: Container(
                                    //     height: 30,
                                    //     padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                    //     margin: const EdgeInsets.only(right: 20),
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.grey.withOpacity(0.4),
                                    //         borderRadius: BorderRadius.circular(8)),
                                    //     child: Row(
                                    //       mainAxisAlignment: MainAxisAlignment.start,
                                    //       children: [
                                    //         Image.asset(IconsAssets.icWaitingAccept),
                                    //         const SizedBox(width: 6),
                                    //         const Text(
                                    //           "Đang theo dõi",
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               fontFamily: 'Nunito Sans',
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      height: 30,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 6, 10, 6),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        children: [
                                          Image.asset(IconsAssets.icChatProfile,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "Nhắn tin",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Nunito Sans',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
                            onTap: () {},
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

                        /// ic back
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /// tab profile
  Widget tabProfile() {
    AnOtherProfileController anOtherProfileController =
        Get.put(AnOtherProfileController());
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
                labelPadding: const EdgeInsets.symmetric(horizontal: (50)),
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
                      Text("Ảnh của ${anOtherProfileController.fullName}",
                          style: const TextStyle(
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
                      Text("Story của ${anOtherProfileController.fullName}",
                          style: const TextStyle(
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
              Tab1(tabController: anOtherProfileController),

              /// story
              Tab2(tabController: anOtherProfileController),
            ],
          ),
        ),
      ],
    );
  }
}

class Tab1 extends StatefulWidget {
  final AnOtherProfileController tabController;
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
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: widget.tabController.listPhotos.isNotEmpty
            ? widget.tabController.listPhotos.length
            : 6,
        itemBuilder: (context, index) {
          if (widget.tabController.isLoading == true) {
            return shimmerContentGridView();
          } else {
            if (widget.tabController.listPhotos.isNotEmpty) {
              return contentGridView(index);
            } else {
              return Container();
            }
          }
        });
  }

  /// content gridview
  Widget contentGridView(index) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRect(
            child: getNetworkImage(widget.tabController.listPhotos[index],
                width: null, height: null)));
  }

  Widget shimmerContentGridView() {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.4),
          highlightColor: Colors.grey,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}

class Tab2 extends StatefulWidget {
  final AnOtherProfileController tabController;
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
        itemCount:
          Global.listFavoriteStoriesAnotherUser.isNotEmpty
        ? Global.listFavoriteStoriesAnotherUser.length
        : 0,
        itemBuilder: (context, index) {
          if (Global.listFavoriteStoriesAnotherUser.isNotEmpty) {
            return contentGridView(index);
          } else {
            return Container();
          }
        });
  }

  /// content gridview
  Widget contentGridView(index) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ClipRect(
        child:
        getNetworkImage(
            Global.listFavoriteStoriesAnotherUser[index].photoPath,
            width: null,
            height: null),
      ),
    );
  }
}
