import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/get_all_photo_another_user/get_all_photo_another_user_request.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_view.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/notification_screen/notification_view.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../../../assets/icons_assets.dart';
import '../../../config/theme_service.dart';
import '../../../models/another_user_profile/another_user_profile_request.dart';
import '../../../util/global.dart';
import '../another_profile_screen/another_profile_screen.dart';
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
                  'SeShare',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                  return contentListViewStoryFirstIndex(
                                      homeController);
                                } else {
                                  return contentListViewStory();
                                }
                              },
                            )),
                        Expanded(
                            child: RefreshIndicator(
                                edgeOffset: 0,
                                displacement: 10,
                                onRefresh: homeController.pullToRefreshData,
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 90),
                                    itemCount: homeController.isLoading == true
                                        ? 5
                                        : homeController
                                            .dataPostsResponse.length,
                                    itemBuilder: (context, index) {
                                      if (homeController.isLoading) {
                                        return skeleton();
                                      } else {
                                        if (homeController.dataPostsResponse !=
                                            null) {
                                          return contentListViewPost(index);
                                        } else {
                                          return skeleton();
                                        }
                                      }
                                    }))),
                      ],
                    )),
              ),
            ));
  }

  /// content list view story
  Widget contentListViewStory() {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => const StoryPage());
            },
            child: Container(
                width: 65,
                height: 65,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(top: 8, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue.withOpacity(0.6),
                        width: 3,
                        style: BorderStyle.solid),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    ImageAssets.imgTet,
                    fit: BoxFit.cover,
                  ),
                )),
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
        Get.to(() => const CreateStoryScreen());
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(left: 5),
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

  /// content list view post wireframe
  Widget skeleton() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.4),
                          highlightColor: Colors.grey,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.withOpacity(0.4)),
                          ),
                        )),

                    /// user name and location
                    Container(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.4),
                            highlightColor: Colors.grey,
                            child: Container(
                              width: 100,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.4),
                            highlightColor: Colors.grey,
                            child: Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
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

          /// image post
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey,
            child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width / 1.25,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.4))),
          ),

          /// caption of post
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey,
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
                margin: const EdgeInsets.only(top: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.4))),
          ),

          /// viewer and commenter
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: //
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          /// icon like + cmt + share
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ic like
                Container(
                    constraints: const BoxConstraints(maxWidth: 80),
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
                const VerticalDivider(),

                /// ic cmt
                Container(
                  constraints: const BoxConstraints(maxWidth: 105),
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
                const VerticalDivider(),

                /// ic share
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// content list view post
  Widget contentListViewPost(index) {
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
                InkWell(
                  onTap: () {
                    if (homeController
                            .dataPostsResponse[index].userInfoResponse!.id !=
                        Global.userProfileResponse!.id) {
                      GetAllPhotoAnotherUserRequest anotherUserRequest =
                          GetAllPhotoAnotherUserRequest(homeController
                              .dataPostsResponse[index].userInfoResponse!.id);
                      AnotherUserProfileRequest anotherProfileRequest = AnotherUserProfileRequest(homeController
                          .dataPostsResponse[index].userInfoResponse!.id);
                      homeController
                          .getListPhotoAnOtherUser(anotherUserRequest);
                      homeController.loadAnotherUserProfile(anotherProfileRequest);
                    }
                    else{
                      Get.offAll(() => NavigationBarView(currentIndex: 4));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///avatar
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: homeController.dataPostsResponse[index]
                                .userInfoResponse!.avatar.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  Global.convertMedia(
                                      homeController.dataPostsResponse[index]
                                          .userInfoResponse!.avatar,
                                      null,
                                      null),
                                  errorBuilder: (context, event, object) {
                                    return Container();
                                  },
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ))
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                              ),
                      ),

                      /// user name and location
                      Container(
                        constraints: const BoxConstraints(maxWidth: 220),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    homeController.dataPostsResponse[index]
                                        .userInfoResponse!.fullName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans')),
                                Container(
                                  width: 85,
                                  margin: const EdgeInsets.only(left: 15),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.4))),
                                  child:

                                      /// public
                                      Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      homeController.dataPostsResponse[index]
                                                  .privacy ==
                                              "public"
                                          ? Image.asset(
                                              IconsAssets.icPublicMode,
                                              width: 12,
                                              height: 12,
                                            )
                                          : homeController
                                                      .dataPostsResponse[index]
                                                      .privacy ==
                                                  "private"
                                              ? Image.asset(
                                                  IconsAssets.icPrivateMode)
                                              : Image.asset(
                                                  IconsAssets.icFriendMode),
                                      Container(
                                        width: 60,
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                            homeController
                                                        .dataPostsResponse[
                                                            index]
                                                        .privacy ==
                                                    "public"
                                                ? "Công khai"
                                                : homeController
                                                            .dataPostsResponse[
                                                                index]
                                                            .privacy ==
                                                        "private"
                                                    ? "Cá nhân"
                                                    : "Bạn bè",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                fontFamily: 'Nunito Sans')),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                                homeController
                                    .dataPostsResponse[index].userLocation,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 13, fontFamily: 'Nunito Sans')),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          (homeController.dataPostsResponse[index].checkInLocation.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(7, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconsAssets.icCheckIn,
                        width: 40,
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        constraints: const BoxConstraints(maxHeight: 40),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Địa điểm bạn nhắc tới: ${homeController.dataPostsResponse[index].checkInLocation}",
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                fontFamily: 'Nunito Sans')),
                      ),
                    ],
                  ),
                )
              : Container(),

          /// image post
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              height: 350,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int indexPath) {
                      return PhotoViewGalleryPageOptions(
                        initialScale: PhotoViewComputedScale.covered,
                        minScale: PhotoViewComputedScale.covered * 0.9,
                        imageProvider: NetworkImage(Global.convertMedia(
                            homeController
                                .dataPostsResponse[index].photoPath![indexPath]
                                .toString(),
                            MediaQuery.of(context).size.width / 1.25,
                            350)),
                      );
                    },
                    itemCount: homeController
                        .dataPostsResponse[index].photoPath!.length,
                    loadingBuilder: (context, event) => Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.grey,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey.withOpacity(0.4))),
                    ),
                  ))),

          /// descriptions of post
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontFamily: 'Nunito Sans'),
                  children: [
                    TextSpan(
                        text:
                            "${homeController.dataPostsResponse[index].userInfoResponse!.fullName}  ",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: homeController.dataPostsResponse[index].caption,
                        style: const TextStyle(fontSize: 14)),
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
                        children: [
                          TextSpan(
                              text: homeController
                                  .dataPostsResponse[index].likes
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          const TextSpan(
                              text: "  Đã Thích",
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
                        children: [
                          TextSpan(
                              text: homeController
                                      .dataPostsResponse[index].cmt!.isEmpty
                                  ? "0"
                                  : homeController.dataPostsResponse[index]
                                      .cmt![index].length
                                      .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          const TextSpan(
                              text: "  Bình Luận",
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
                              text: "999K",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          TextSpan(
                              text: "  Lượt lưu",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Nunito Sans')),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          /// icon like + cmt + share
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            height: 30,
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
                const VerticalDivider(),

                /// ic cmt
                GestureDetector(
                  onTap: () {
                    Get.to(() => const CommentScreen());
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 105),
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
                const VerticalDivider(),

                /// ic share
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icSave),
                          const SizedBox(width: 10),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 70),
                            child: Text("Lưu",
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
                          style: const TextStyle(
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
                          style: const TextStyle(
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
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
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
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Hủy chọn".toUpperCase(),
                  style: const TextStyle(
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
