import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/list_comments_post/list_comments_post_request.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/home_screen/update_post_screen/update_post_view.dart';
import 'package:instagram_app/page/main/notification_screen/notification_view.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/global.dart';
import '../../../util/module.dart';
import 'home_controller.dart';
import 'infor_account_screen/infro_account_view.dart';

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
                      fontFamily: 'Nunito Sans',
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
                                        : Global.listPostInfo.length,
                                    itemBuilder: (context, index) {
                                      if (homeController.isLoading) {
                                        return skeleton();
                                      } else {
                                        if (Global.listPostInfo.isNotEmpty) {
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
                            width: 60,
                            height: 60,
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
                GestureDetector(
                  onTap: () {
                    if (Global.listPostInfo[index].userInfoResponse!.id !=
                        Global.userProfileResponse!.id) {
                      homeController.userIdForLoadListAnotherProfile =
                          Global.listPostInfo[index].userInfoResponse!.id;
                      homeController.loadListPhotoAnotherUser();
                      homeController.loadAnotherProfile();
                    } else {
                      Get.offAll(() => NavigationBarView(currentIndex: 4));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///avatar
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Global.listPostInfo[index].userInfoResponse!
                                .avatar.isNotEmpty
                            ? SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: getNetworkImage(
                                        Global.listPostInfo[index]
                                            .userInfoResponse!.avatar,
                                        width: 60,
                                        height: 60)),
                              )
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                              ),
                      ),

                      /// full name of user
                      Container(
                        constraints: const BoxConstraints(maxWidth: 220),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                Global.listPostInfo[index].userInfoResponse!
                                    .fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans')),
                            const SizedBox(height: 4),

                            /// create post time and mode privacy
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(Global.listPostInfo[index].updatedAt!,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Nunito Sans')),
                                const SizedBox(width: 10),
                                /// public
                                Global.listPostInfo[index].privacy == "public"
                                    ? Image.asset(IconsAssets.icPublicMode,
                                        width: 13,
                                        height: 13,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                    : Global.listPostInfo[index].privacy ==
                                            "private"
                                        ? Image.asset(IconsAssets.icPrivateMode,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black)
                                        : Image.asset(IconsAssets.icFriendMode,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                              ],
                            ),
                            // Text(Global.listPostInfo[index].userLocation,
                            //     maxLines: 2,
                            //     style: const TextStyle(
                            //         fontSize: 13, fontFamily: 'Nunito Sans')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// dot
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return detailBottomSheetMenuDot(
                              homeController, index);
                        });
                  },
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(IconsAssets.icDot),
                  ),
                ),
              ],
            ),
          ),

          (Global.listPostInfo[index].checkInLocation.isNotEmpty)
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
                            "Địa điểm bạn nhắc tới: ${Global.listPostInfo[index].checkInLocation}",
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

          /// caption of post
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 20),
              child: Text(
                Global.listPostInfo[index].caption!,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400),
              )

              // RichText(
              //   text: TextSpan(
              //       style: TextStyle(
              //           color: Theme.of(context).textTheme.headline6?.color,
              //           fontFamily: 'Nunito Sans'),
              //       children: [
              //         TextSpan(
              //             text:
              //             "${ Global.listPostInfo[index].userInfoResponse!.fullName}  ",
              //             style: const TextStyle(
              //                 fontSize: 14, fontWeight: FontWeight.bold)),
              //         TextSpan(
              //             text:  Global.listPostInfo[index].caption,
              //             style: const TextStyle(fontSize: 14)),
              //       ]),
              // ),
              ),

          /// image post
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              height: 350,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    itemCount: Global.listPostInfo[index].photoPath!.length,
                    builder: (BuildContext context, int indexPath) {
                      return PhotoViewGalleryPageOptions(
                          initialScale: PhotoViewComputedScale.covered,
                          minScale: PhotoViewComputedScale.covered * 0.95,
                          imageProvider: NetworkImage(Global.convertMedia(
                              Global.listPostInfo[index].photoPath![indexPath]
                                  .toString(),
                              MediaQuery.of(context).size.width / 1.25,
                              350)),
                          errorBuilder: (context, event, stackTrace) =>
                              Container(color: Colors.grey));
                    },
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

          /// viewer and commenter and Saver
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: //
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline6?.color,
                            fontFamily: 'NunitoSans'),
                        children: [
                          TextSpan(
                              text: Global.listPostInfo[index].totalLikes
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
                              text: Global.listPostInfo[index].totalCmt == 0
                                  ? "0"
                                  : Global.listPostInfo[index].totalCmt
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
                              text: "999K",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito Sans')),
                          TextSpan(
                              text: "  Lượt Lưu",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: 'Nunito Sans')),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),

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
                    if (Global.listPostInfo[index].id.isNotEmpty) {
                      homeController.postIdForLikePost =
                          Global.listPostInfo[index].id;
                      homeController.handleLikePost();
                    }
                  },
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (Global.listPostInfo[index].liked == true)
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
                VerticalDivider(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
                /// ic cmt
                GestureDetector(
                  onTap: () {
                    if (Global.isAvailableToClick()) {
                      if (Global.listPostInfo[index].id.isNotEmpty) {
                        Global.idPost = Global.listPostInfo[index].id;
                        ListCommentsPostRequest request =
                            ListCommentsPostRequest(
                                Global.listPostInfo[index].id);
                        homeController.getListCommentsPost(request);
                      }
                    }
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
                VerticalDivider(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),

                /// ic share
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icSave,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
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
              GestureDetector(
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
              GestureDetector(
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

  Widget detailBottomSheetMenuDot(HomeController homeController, index) {
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
            height: 280,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: (Global.listPostInfo[index].userInfoResponse!.id !=
                    Global.userProfileResponse!.id)
                ? Column(
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
                          //Get.to(() => const SettingScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(IconsAssets.icStar),
                            const SizedBox(width: 10),
                            const Text(
                              "Thêm vào mục yêu thích",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                      /// unfollow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icUnfollow),
                          const SizedBox(width: 10),
                          const Text(
                            "Bỏ theo dõi",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                color: Colors.black),
                          ),
                        ],
                      ),

                      /// the reason seeing the post
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return detailBottomSheetReasonSeeingThePost(
                                    index);
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(IconsAssets.icInfoApp),
                            const SizedBox(width: 10),
                            const Text(
                              "Lý do bạn nhìn thấy bài viết này",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icQRCode),
                          const SizedBox(width: 10),
                          const Text(
                            "Mã QR",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                color: Colors.black),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => InForAccountScreen(isMyAccount: false));
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
                  )
                : Column(
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
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icWaitingAccept),
                              const SizedBox(width: 10),
                              const Text(
                                "Lưu trữ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icHideLike),
                              const SizedBox(width: 10),
                              const Text(
                                "Ẩn lượt thích",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          homeController.hideCmt = !homeController.hideCmt;
                          homeController.update();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icHideCmt),
                              const SizedBox(width: 10),
                              const Text(
                                "Tắt tính năng bình luận",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /// update post
                      GestureDetector(
                        onTap: (){
                          Global.infoMyPost = Global.listPostInfo[index];
                          Get.to(() => const UpdatePostScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icEditPost),
                              const SizedBox(width: 10),
                              const Text(
                                "Chỉnh sửa",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /// qr code
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(IconsAssets.icQRCode),
                            const SizedBox(width: 10),
                            const Text(
                              "Mã QR",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      /// delete post
                      GestureDetector(
                        onTap: () {
                          if (Global.isAvailableToClick()) {
                            Get.defaultDialog(
                                backgroundColor: Colors.white,
                                titleStyle: const TextStyle(
                                    color: Colors.black, fontFamily: 'Nunito Sans'),
                                title: "Xóa bài viết",
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
                                    Navigator.pop(context);
                                    homeController.postIdForDeletePost = Global.listPostInfo[index].id;
                                    homeController.handleDeletePost();
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
                                    "Bạn có chắc là muốn xóa bài viết không?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: 'Nunito Sans')));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icDeletePost,
                                  color: Colors.redAccent),
                              const SizedBox(width: 10),
                              const Text(
                                "Xóa",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
      ],
    );
  }

  Widget detailBottomSheetReasonSeeingThePost(index) {
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
            height: 280,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),
                const Text("Lý do bạn nhìn thấy bài viết này",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Colors.grey),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: const Text(
                    "Hệ thống hiển thị bài viết trong bảng feed dựa theo nhiều yếu tố, bao gồm cả hoạt động của bạn trên SeShare.",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Nunito Sans',
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: getNetworkImage(
                              Global
                                  .listPostInfo[index].userInfoResponse!.avatar,
                              width: 60,
                              height: 60)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 275
                      ),
                      height: 40,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black, fontFamily: 'Nunito Sans'),
                            children: [
                              TextSpan(
                                  text:
                                      "${Global.listPostInfo[index].userInfoResponse!.fullName} ",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: "đang đăng ở chế độ ",
                                  style: TextStyle(fontSize: 14)),
                              const TextSpan(
                                  text: "Công khai ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: "hoặc ",
                                  style: TextStyle(fontSize: 14)),
                              const TextSpan(
                                  text: "Bạn bè",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
