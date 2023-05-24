import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/another_profile_screen/another_profile_controller.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/profile_screen/list_pending/list_my_friend/list_my_friend_view.dart';
import 'package:instagram_app/page/main/profile_screen/list_pending/list_peding_view.dart';
import 'package:instagram_app/page/main/search_screen/action_search/action_search_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/global.dart';
import '../../../util/module.dart';
import '../home_screen/infor_account_screen/infro_account_view.dart';
import '../profile_screen/posts_archive/post_archive_screen.dart';

class AnOtherProfileScreen extends StatefulWidget {
  bool? isMyFriendPage = false;
  bool? isActionSearchPage = false;
  bool? isMyPendingPage = false;
  AnOtherProfileScreen(
      {Key? key,
      this.isMyFriendPage,
      this.isActionSearchPage,
      this.isMyPendingPage})
      : super(key: key);

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
                        Global.anOtherUserProfileResponse!.backgroundPath!
                                .isNotEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                child: getNetworkImage(
                                    Global.anOtherUserProfileResponse!
                                        .backgroundPath!,
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
                                        child: Global
                                                .anOtherUserProfileResponse!
                                                .avatarPath!
                                                .isNotEmpty
                                            ? getNetworkImage(
                                                Global
                                                    .anOtherUserProfileResponse!
                                                    .avatarPath!,
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
                                    Global.anOtherUserProfileResponse!.fullName
                                            .isNotEmpty
                                        ? Text(
                                            Global.anOtherUserProfileResponse!
                                                .fullName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                fontFamily: 'Nunito Sans'))
                                        : Container(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Global.anOtherUserProfileResponse!.bio!
                                            .isNotEmpty
                                        ? Text(
                                            Global.anOtherUserProfileResponse!
                                                .bio!,
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
                                    children: [
                                      Text(
                                          Global.listAnotherPost.length
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'Nunito Sans')),
                                      const Text("Bài đăng",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              fontFamily: 'Nunito Sans')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          Global.listFavoriteStoriesAnotherUser
                                              .length
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'Nunito Sans')),
                                      const Text("Tin nổi bật",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              fontFamily: 'Nunito Sans')),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(Global.anOtherUserProfileResponse!.totalFriend.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'Nunito Sans')),
                                      const Text("Bạn bè",
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
                                    /// not friend
                                    Global.anOtherUserProfileResponse!
                                                .friendStatus ==
                                            0
                                        ? GestureDetector(
                                            onTap: () {
                                              anOtherProfileController
                                                  .handleAddFriend();
                                            },
                                            child: Container(
                                              height: 30,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 7, 10, 7),
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                      IconsAssets.icAddFriend,
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
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )

                                        /// waiting friend
                                        : Global.anOtherUserProfileResponse!
                                                    .friendStatus ==
                                                1
                                            ? GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) {
                                                        return detailBottomSheetUnSendRequest(
                                                            anOtherProfileController);
                                                      });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 7, 10, 7),
                                                  margin: const EdgeInsets.only(
                                                      right: 20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(IconsAssets
                                                          .icWaitingAccept),
                                                      const SizedBox(width: 6),
                                                      const Text(
                                                        "Đã gửi lời mời",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )

                                            /// response for requester
                                            : Global.anOtherUserProfileResponse!
                                                        .friendStatus ==
                                                    2
                                                ? GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) {
                                                           return detailBottomSheetResponseForRequester(anOtherProfileController);
                                                          });
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 10, 7),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.25),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(IconsAssets
                                                              .icWaitingAccept),
                                                          const SizedBox(
                                                              width: 6),
                                                          const Text(
                                                            "Phản hồi",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                /// friend
                                                : GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) {
                                                            return detailBottomSheetUnfriend(
                                                                anOtherProfileController);
                                                          });
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 7, 10, 7),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.25),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                              IconsAssets
                                                                  .icFriend),
                                                          const SizedBox(
                                                              width: 6),
                                                          const Text(
                                                            "Bạn bè",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Nunito Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                    Container(
                                      height: 30,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 7, 10, 7),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.25),
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
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return detailBottomSheetMenuDot(
                                        anOtherProfileController);
                                  });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(top: 20, right: 20),
                              child: const Icon(Icons.menu,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset.zero,
                                        blurRadius: 5)
                                  ]),
                              // Image.asset(
                              //   IconsAssets.icDot,
                              //   color: Colors.white,
                              // ),
                            ),
                          ),
                        ),

                        /// ic back
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              widget.isMyFriendPage == true
                                  ? Get.to(() => const ListMyFriendScreen())
                                  : widget.isActionSearchPage == true
                                      ? Get.to(() => const ActionSearchScreen())
                                      : widget.isMyPendingPage == true
                                          ? Get.to(
                                              () => const ListPendingScreen())
                                          : anOtherProfileController
                                              .getListPosts();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset.zero,
                                        blurRadius: 5)
                                  ]),
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
                labelPadding: const EdgeInsets.symmetric(horizontal: (35)),
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
                      Text(
                          "Ảnh của ${Global.anOtherUserProfileResponse!.fullName}",
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
                          child: Image.asset(IconsAssets.icStories)),
                      const SizedBox(height: 5),
                      Text(
                          "Tin nổi bật của ${Global.anOtherUserProfileResponse!.fullName}",
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

  Widget detailBottomSheetMenuDot(
      AnOtherProfileController anOtherProfileController) {
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
            height: 150,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),

                /// qr code
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.defaultDialog(
                      backgroundColor: Colors.white,
                      barrierDismissible: false,
                      title: "",
                      confirm: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Divider(color: Colors.black.withOpacity(0.4)),

                            /// save QR code
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                anOtherProfileController.screenShotController
                                    .capture()
                                    .then((Uint8List? image) async {
                                  //Capture Done
                                  anOtherProfileController.imageFile = image;

                                  Directory tempDir =
                                      await getTemporaryDirectory();

                                  File tempFile =
                                      await File('${tempDir.path}/QR.png')
                                          .create();

                                  await tempFile.writeAsBytes(
                                      anOtherProfileController.imageFile!);

                                  anOtherProfileController.qrFilePath =
                                      tempFile.path;

                                  await anOtherProfileController.saveImage(
                                      anOtherProfileController.qrFilePath);

                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Thành công!',
                                      message: "Đã lưu mã QR",
                                      contentType: ContentType.success,
                                    ),
                                  );
                                  ScaffoldMessenger.of(Get.context!)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  anOtherProfileController.update();
                                  debugPrint(
                                      anOtherProfileController.qrFilePath);
                                }).catchError((onError) {
                                  debugPrint(onError);
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 35,
                                alignment: Alignment.center,
                                child: const Text("Lưu mã QR",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito Sans')),
                              ),
                            ),
                            Divider(color: Colors.black.withOpacity(0.4)),

                            /// cancel
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 80,
                                height: 35,
                                alignment: Alignment.center,
                                child: const Text("Xong",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito Sans')),
                              ),
                            ),
                          ],
                        ),
                      ),
                      radius: 12,

                      /// QR code
                      content: Screenshot(
                        controller:
                            anOtherProfileController.screenShotController,
                        child: Container(
                          width: 200,
                          height: 250,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 170,
                                height: 180,
                                child: QrImage(
                                  data: Global.anOtherUserProfileResponse!.id,
                                  size: 170,
                                  version: QrVersions.auto,
                                ),
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    const TextSpan(
                                        text: 'Trang cá nhân của \n',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Nunito Sans',
                                            color: Colors.black)),
                                    TextSpan(
                                        text: Global.anOtherUserProfileResponse!
                                            .fullName,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(IconsAssets.icQRCode),
                        const SizedBox(width: 10),
                        Text(
                          "Mã QR của ${Global.anOtherUserProfileResponse!.fullName}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                /// info account
                GestureDetector(
                  onTap: () {
                    Get.to(() => InForAccountScreen(
                          isAnotherProfilePage: true,
                          isMyAccount: false,
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icInforAccount),
                      const SizedBox(width: 10),
                      const Text(
                        "Giới thiệu về tài khoản này",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget detailBottomSheetUnfriend(
      AnOtherProfileController anOtherProfileController) {
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
            height: 120,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    anOtherProfileController.handleDenyOrUnfriend();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icDeleteFriend),
                      const SizedBox(width: 10),
                      const Text(
                        "Hủy kết bạn",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icCancel),
                      const SizedBox(width: 10),
                      const Text(
                        "Bỏ qua",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget detailBottomSheetUnSendRequest(
      AnOtherProfileController anOtherProfileController) {
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
            height: 120,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    anOtherProfileController.handleDenyOrUnfriend();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icDeleteFriend),
                      const SizedBox(width: 10),
                      const Text(
                        "Hủy yêu cầu",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icCancel),
                      const SizedBox(width: 10),
                      const Text(
                        "Bỏ qua",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget detailBottomSheetResponseForRequester(
      AnOtherProfileController anOtherProfileController) {
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
            height: 120,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    anOtherProfileController.handleAcceptFriend();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icFriend),
                      const SizedBox(width: 10),
                      const Text(
                        "Chấp nhận lời mời",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    anOtherProfileController.handleDenyOrUnfriend();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(IconsAssets.icCancel),
                      const SizedBox(width: 10),
                      const Text(
                        "Xóa lời mời",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
        itemCount: Global.listPhotoAnOtherUser.isNotEmpty
            ? Global.listPhotoAnOtherUser.length
            : 6,
        itemBuilder: (context, index) {
          if (widget.tabController.isLoading == true) {
            return shimmerContentGridView();
          } else {
            if (Global.listPhotoAnOtherUser.isNotEmpty) {
              return contentGridView(widget.tabController, index);
            } else {
              return Container();
            }
          }
        });
  }

  /// content gridview
  Widget contentGridView(
      AnOtherProfileController anOtherProfileController, index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostArchiveScreen(isAnotherPost: true));
      },
      child: Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRect(
              child: getNetworkImage(Global.listPhotoAnOtherUser[index],
                  width: null, height: null))),
    );
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
        itemCount: Global.listFavoriteStoriesAnotherUser.isNotEmpty
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
    return GestureDetector(
      onTap: () {
        Get.to(() =>
            StoryPage(isAnotherUserFavoriteStoryPage: true, index: index));
      },
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRect(
          child: getNetworkImage(
              Global.listFavoriteStoriesAnotherUser[index].photoPath,
              width: null,
              height: null),
        ),
      ),
    );
  }
}
