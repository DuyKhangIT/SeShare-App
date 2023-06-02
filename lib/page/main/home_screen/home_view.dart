import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/hide_comment_post/hide_comment_post_request.dart';
import 'package:instagram_app/models/hide_like_post/hide_like_post_request.dart';
import 'package:instagram_app/models/list_comments_post/list_comments_post_request.dart';
import 'package:instagram_app/page/main/home_screen/create_story/create_story_view.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/home_screen/update_post_screen/update_post_view.dart';
import 'package:instagram_app/page/main/notification_screen/notification_view.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/global.dart';
import '../../../util/module.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

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
                              itemCount: homeController.isLoading == true
                                  ? 5
                                  : Global.listStoriesData.length + 1,
                              itemBuilder: (context, index) {
                                if (homeController.isLoading) {
                                  return skeletonListViewStory(index);
                                } else {
                                  if (index == 0) {
                                    return contentListViewStoryFirstIndex();
                                  } else {
                                    return contentListViewStory(homeController,index - 1);
                                  }
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
                                    }
                                    ))),
                      ],
                    )),
              ),
            ));
  }

  /// content list view story
  Widget contentListViewStory(HomeController homeController, index) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (Global.listStoriesData.isNotEmpty) {
                Get.to(() => StoryPage(index: index));
              }
            },
            child: Container(
                width: 65,
                height: 65,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(top: 8, bottom: 5),
                decoration:
                    BoxDecoration(
                        border: Border.all(
                            color: Colors.blue.withOpacity(0.6),
                            width: 3,
                            style: BorderStyle.solid),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: getNetworkImage(
                      Global
                          .listStoriesData[index].userInfoStoryResponse!.avatar,
                      width: 65,
                      height: 65),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
                Global.listStoriesData[index].userInfoStoryResponse!.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
          ),
        ],
      ),
    );
  }

  Widget skeletonListViewStory(index) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
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
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.8),
              child: Container(
                width: 65,
                height: 12,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// content list view story index == 0
  Widget contentListViewStoryFirstIndex() {
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
            padding: const EdgeInsets.only(left: 14, right: 30, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// avatar + username + location
                GestureDetector(
                  onTap: () {
                    if (Global.listPostInfo[index].userInfoResponse!.id !=
                        Global.userProfileResponse!.id) {
                      homeController.userIdForLoadListAnotherProfile =
                          Global.listPostInfo[index].userInfoResponse!.id;
                      Global.userIdFromIndexPost = Global.listPostInfo[index].userInfoResponse!.id;
                      homeController.loadListPhotoAnotherUser();
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
                                            width: 13,
                                            height: 13,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,)
                                        : Image.asset(IconsAssets.icFriendMode,
                                            width: 13,
                                            height: 13,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                              ],
                            ),
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
              )),

          /// image post
          Global.listPostInfo[index].photoPath!.isEmpty
          ? Container()
          : SizedBox(
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
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: //
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              text: Global.listPostInfo[index].hideLike == true
                              ?''
                              :Global.listPostInfo[index].totalLikes.toString(),
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
                      homeController.postIdForLikePost = Global.listPostInfo[index].id;
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
                      if(Global.listPostInfo[index].hideCmt == true){
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Cảnh báo!',
                            message: "Chức năng bình luận đã bị chủ bài viết ẩn",
                            contentType: ContentType.warning,
                          ),
                        );
                        ScaffoldMessenger.of(Get.context!)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }else{
                        if (Global.listPostInfo[index].id.isNotEmpty) {
                          Global.idPost = Global.listPostInfo[index].id;
                          ListCommentsPostRequest request =
                          ListCommentsPostRequest(
                              Global.listPostInfo[index].id);
                          homeController.getListCommentsPost(request);
                        }
                      }
                    }
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 110),
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
                          child:
                          Global.listPostInfo[index].hideCmt == true
                          ?Image.asset(IconsAssets.icHideCmt)
                          :Image.asset(IconsAssets.icComment),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          constraints: BoxConstraints(maxWidth: Global.listPostInfo[index].hideCmt == true ?75:60),
                          child: Text(
                            Global.listPostInfo[index].hideCmt == true
                            ?"Ẩn bình luận":"Bình Luận",
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
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconsAssets.icShare,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
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
            height: 200,
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
                      GestureDetector(
                        onTap: () {
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
                                    onTap: () async {
                                      Navigator.pop(context);
                                      homeController.screenShotController.capture().then((Uint8List? image) async {

                                        //Capture Done
                                        homeController.imageFile = image;

                                        Directory tempDir = await getTemporaryDirectory();

                                        File tempFile = await File('${tempDir.path}/QR.png').create();

                                        await tempFile.writeAsBytes(homeController.imageFile!);

                                        homeController.qrFilePath = tempFile.path;

                                        await homeController.saveImage(homeController.qrFilePath);

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

                                        homeController.update();
                                        debugPrint(homeController.qrFilePath);

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
                              controller: homeController.screenShotController,
                              child: Container(
                                width: 200,
                                height: 270,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black,width: 0.5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 180,
                                      child: QrImage(
                                        data: Global.listPostInfo[index].id,
                                        size: 170,
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.center,
                                        text: TextSpan(children: [
                                          const TextSpan(
                                              text: 'Bài viết được chia sẻ của \n',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito Sans',
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: Global.listPostInfo[index].userInfoResponse!.fullName,
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
                      ),
                      GestureDetector(
                        onTap: () {
                          homeController.userIdForLoadListAnotherProfile =
                              Global.listPostInfo[index].userInfoResponse!.id;
                          homeController.loadAnotherProfileForInfoAnotherUser();
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
                      Global.listPostInfo[index].hideLike == true
                      ?GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          HideLikePostRequest hideLikePostRequest = HideLikePostRequest(Global.listPostInfo[index].id);
                          homeController.hideLikePost(hideLikePostRequest);
                          homeController.update();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icLike),
                              const SizedBox(width: 10),
                              const Text(
                                "Hiện lượt thích",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                      :GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          HideLikePostRequest hideLikePostRequest = HideLikePostRequest(Global.listPostInfo[index].id);
                          homeController.hideLikePost(hideLikePostRequest);
                          homeController.update();
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
                      Global.listPostInfo[index].hideCmt == true
                      ?GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          HideCommentPostRequest hideCommentRequest = HideCommentPostRequest(Global.listPostInfo[index].id);
                          homeController.hideCmtPost(hideCommentRequest);
                          homeController.update();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(IconsAssets.icComment),
                              const SizedBox(width: 10),
                              const Text(
                                "Mở tính năng bình luận",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nunito Sans',
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                      :GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          HideCommentPostRequest hideCommentRequest = HideCommentPostRequest(Global.listPostInfo[index].id);
                          homeController.hideCmtPost(hideCommentRequest);
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
                        onTap: () {
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
                      GestureDetector(
                        onTap: () {
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
                                    onTap: () async {
                                      Navigator.pop(context);
                                      homeController.screenShotController.capture().then((Uint8List? image) async {

                                        //Capture Done
                                        homeController.imageFile = image;

                                        Directory tempDir = await getTemporaryDirectory();

                                        File tempFile = await File('${tempDir.path}/QR.png').create();

                                        await tempFile.writeAsBytes(homeController.imageFile!);

                                        homeController.qrFilePath = tempFile.path;

                                        await homeController.saveImage(homeController.qrFilePath);

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

                                        homeController.update();
                                        debugPrint(homeController.qrFilePath);

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
                              controller: homeController.screenShotController,
                              child: Container(
                                width: 200,
                                height: 250,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black,width: 0.5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 170,
                                      height: 180,
                                      child: QrImage(
                                        data: Global.listPostInfo[index].id,
                                        size: 170,
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: [
                                          const TextSpan(
                                              text: 'Bài viết được chia sẻ của \n',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito Sans',
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: Global.listPostInfo[index].userInfoResponse!.fullName,
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
                      ),

                      /// delete post
                      GestureDetector(
                        onTap: () {
                          if (Global.isAvailableToClick()) {
                            Get.defaultDialog(
                                backgroundColor: Colors.white,
                                titleStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Nunito Sans'),
                                title: "Xóa bài viết",
                                barrierDismissible: false,
                                cancel: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.blue,
                                            style: BorderStyle.solid)),
                                    child: const Text("Hủy",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Nunito Sans')),
                                  ),
                                ),
                                confirm: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    homeController.postIdForDeletePost =
                                        Global.listPostInfo[index].id;
                                    homeController.handleDeletePost();
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.blue,
                                            style: BorderStyle.solid)),
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
            height: 220,
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
                  margin: const EdgeInsets.only(bottom: 10),
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
                      constraints: const BoxConstraints(maxWidth: 275),
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
