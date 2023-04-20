import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/story_data.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_view.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/notification_screen/notification_view.dart';
import 'package:instagram_app/widget/avatar_circle.dart';

import '../../../assets/icons_assets.dart';
import '../../../config/theme_service.dart';
import '../../../util/global.dart';
import '../../onboarding/login/login_view.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                automaticallyImplyLeading: false,
                title: Text(
                  'Trang chủ',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      ThemeService().changeTheme();
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 10),
                      child: ColorFiltered(
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
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(IconsAssets.icNotification),
                    ),
                  ),
                ],
                elevation: 0,
              ),
              body: SafeArea(
                child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black54
                        : Colors.blueGrey.withOpacity(0.3),
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black54
                                    : Colors.white,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return contentListViewStoryFirstIndex(homeController);
                                } else {
                                  return contentListViewStory();
                                }
                              },
                            )),
                        Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 90),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return contentListViewPost();
                                })),
                      ],
                    )),
              ),
            ));
  }

  /// content list view story
  Widget contentListViewStory() {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarStory(
            image: ImageAssets.imgTet,
            onTap: () {
              Get.to(() => StoryPage());
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Duy Khang",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
          ),
        ],
      ),
    );
  }

  /// content list view story index == 0
  Widget contentListViewStoryFirstIndex(homeController) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CreateStoryScreen());
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              margin: const EdgeInsets.only(top: 8, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)),
              child: Image.asset(IconsAssets.icPost),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Tin của bạn",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
            ),
          ],
        ),
      ),
    );
  }

  /// content list view post
  Widget contentListViewPost() {
    HomeController homeController = Get.put(HomeController());
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 25, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// avatar + username + location
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///avatar
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          ImageAssets.imgTet,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),

                    /// user name and location
                    Container(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Duy Khang",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans')),
                          const SizedBox(height: 4),
                          Text(Global.currentLocation,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontFamily: 'Nunito Sans')),
                        ],
                      ),
                    ),
                  ],
                ),

                /// dot
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(IconsAssets.icDot),
                ),
              ],
            ),
          ),
          (Global.checkIn != null && Global.checkIn.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconsAssets.icLocationPost,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 40,
                        child: Text("Địa điểm bạn nhắc tới: ${Global.checkIn}",
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans')),
                      ),
                    ],
                  ),
                )
              : Container(),

          /// image post
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Image.asset(ImageAssets.imgTet))),

          /// descriptions of post
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontFamily: 'Nunito Sans'),
                  children: const [
                    TextSpan(
                        text: "Duy Khang  ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Đi Vũng Tàu xả stress",
                        style: TextStyle(fontSize: 14)),
                  ]),
            ),
          ),

          /// viewer and commenter
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: //
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 7.5),
                  alignment: Alignment.center,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline6?.color,
                            fontFamily: 'NunitoSans'),
                        children: const [
                          TextSpan(
                              text: "1K ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          TextSpan(
                              text: "Đã Thích",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Nunito Sans')),
                        ]),
                  ),
                ),
                Container(
                  width: 85,
                  alignment: Alignment.center,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline6?.color,
                            fontFamily: 'NunitoSans'),
                        children: const [
                          TextSpan(
                              text: "999K ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          TextSpan(
                              text: "Bình Luận",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Nunito Sans')),
                        ]),
                  ),
                ),
                Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline6?.color,
                            fontFamily: 'NunitoSans'),
                        children: const [
                          TextSpan(
                              text: "999K ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          TextSpan(
                              text: "Chia sẻ",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Nunito Sans')),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          /// icon like + cmt
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ic like
                GestureDetector(
                  onTap: () {
                    homeController.isLike = !homeController.isLike;
                    homeController.update();
                  },
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (homeController.isLike == true)
                              ? ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.red
                                        : Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                  child: Image.asset(IconsAssets.icLikeRed),
                                )
                              : ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                  child: Image.asset(IconsAssets.icLike),
                                ),
                          const SizedBox(width: 10),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 45),
                            child: Text("Thích",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                ),

                /// ic cmt
                GestureDetector(
                  onTap: () {
                    Get.to(() => const CommentScreen());
                  },
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 105),
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
                          child: Image.asset(IconsAssets.icComment),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          constraints: const BoxConstraints(maxWidth: 60),
                          child: Text(
                            "Bình Luận",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ic share
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icShare),
                          const SizedBox(width: 10),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 70),
                            child: Text("Chia sẻ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailBottomSheetAddImage(homeController) {
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
          margin: const EdgeInsets.only(left: 31, right: 31, bottom: 26),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    homeController.getImageFromCamera();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chụp ảnh".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),
              InkWell(
                  onTap: () {
                    homeController.getImageFromGallery();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("Chọn ảnh từ thư viện".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                    ),
                  )),
            ],
          ),
        ),

        /// BUTTON CANCEL
        Padding(
            padding: EdgeInsets.only(bottom: 34, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                  shadowColor: Colors.black,
                  side: BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            ))
      ],
    );
  }
}
