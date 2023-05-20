import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/another_profile_screen/another_profile_screen.dart';
import 'package:instagram_app/page/main/profile_screen/posts_archive/post_archive_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../models/list_comments_post/list_comments_post_request.dart';
import '../../../../util/global.dart';
import '../../../../util/module.dart';
import '../../../navigation_bar/navigation_bar_view.dart';

class PostArchiveScreen extends StatefulWidget {
  bool? isAnotherPost = false;
  PostArchiveScreen({Key? key, this.isAnotherPost}) : super(key: key);

  @override
  State<PostArchiveScreen> createState() => _PostArchiveScreenState();
}

class _PostArchiveScreenState extends State<PostArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    PostArchiveController postArchiveController =
        Get.put(PostArchiveController());
    return GetBuilder<PostArchiveController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    widget.isAnotherPost == true
                        ? Get.to(() => const AnOtherProfileScreen())
                        : Get.to(() => NavigationBarView(currentIndex: 4));
                  },
                  child: Icon(Icons.arrow_back,
                      color: Theme.of(context).textTheme.headline6?.color),
                ),
                title: Text(
                    widget.isAnotherPost == true
                        ? "Bài viết ${Global.anOtherUserProfileResponse!.fullName}"
                        : "Bài viết của bạn",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline6?.color,
                    )),
                elevation: 0,
              ),
              body: SafeArea(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 90),
                    itemCount:
                    widget.isAnotherPost==true
                    ?postArchiveController.dataAnotherPost.isNotEmpty
                        ? postArchiveController.dataAnotherPost.length
                        : 3
                    :postArchiveController.data.isNotEmpty
                        ? postArchiveController.data.length
                        : 3,
                    itemBuilder: (context, index) {
                      if (postArchiveController.isLoading) {
                        return skeleton();
                      } else {
                        if (widget.isAnotherPost == true) {
                          if (postArchiveController
                              .dataAnotherPost.isNotEmpty) {
                            return contentListViewMyPost(
                                postArchiveController, index);
                          } else {
                            return skeleton();
                          }
                        } else {
                          if (postArchiveController.data.isNotEmpty) {
                            return contentListViewMyPost(
                                postArchiveController, index);
                          } else {
                            return skeleton();
                          }
                        }
                      }
                    }),
              )),
            ));
  }

  /// content list view post
  Widget contentListViewMyPost(
      PostArchiveController postArchiveController, index) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
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
                      child: widget.isAnotherPost == true
                          ? postArchiveController.dataAnotherPost[index]
                                  .userInfoResponse!.avatar.isNotEmpty
                              ? SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: getNetworkImage(
                                          postArchiveController
                                              .dataAnotherPost[index]
                                              .userInfoResponse!
                                              .avatar,
                                          width: 60,
                                          height: 60)),
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white),
                                )
                          : postArchiveController.data[index].userInfoResponse!
                                  .avatar.isNotEmpty
                              ? SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: getNetworkImage(
                                          postArchiveController.data[index]
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
                              widget.isAnotherPost == true
                                  ? postArchiveController.dataAnotherPost[index]
                                      .userInfoResponse!.fullName
                                  : postArchiveController
                                      .data[index].userInfoResponse!.fullName,
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
                              Text(
                                  widget.isAnotherPost == true
                                      ? postArchiveController
                                          .dataAnotherPost[index].updatedAt!
                                      : postArchiveController
                                          .data[index].updatedAt!,
                                  style: const TextStyle(
                                      fontSize: 13, fontFamily: 'Nunito Sans')),
                              const SizedBox(width: 10),

                              /// public
                              widget.isAnotherPost == true
                                  ? postArchiveController.dataAnotherPost[index].privacy ==
                                          "public"
                                      ? Image.asset(IconsAssets.icPublicMode,
                                          width: 12,
                                          height: 12,
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                      : postArchiveController.dataAnotherPost[index].privacy ==
                                              "private"
                                          ? Image.asset(IconsAssets.icPrivateMode,
                                              width: 12,
                                              height: 12,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)
                                          : Image.asset(IconsAssets.icFriendMode,
                                              width: 12,
                                              height: 12,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)
                                  : postArchiveController.data[index].privacy ==
                                          "public"
                                      ? Image.asset(IconsAssets.icPublicMode,
                                          width: 12,
                                          height: 12,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                      : postArchiveController.data[index].privacy == "private"
                                          ? Image.asset(IconsAssets.icPrivateMode, width: 12, height: 12, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                          : Image.asset(IconsAssets.icFriendMode, width: 12, height: 12, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                widget.isAnotherPost == true
                ?Container()
                /// dot
                :GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return detailBottomSheetMenuDot(
                              postArchiveController, index);
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

          widget.isAnotherPost == true
          ? (postArchiveController.dataAnotherPost[index].checkInLocation.isNotEmpty)
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
                      "Địa điểm bạn nhắc tới: ${postArchiveController.dataAnotherPost[index].checkInLocation}",
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'Nunito Sans')),
                ),
              ],
            ),
          )
              : Container()
          :(postArchiveController.data[index].checkInLocation.isNotEmpty)
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
                            "Địa điểm bạn nhắc tới: ${postArchiveController.data[index].checkInLocation}",
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
                widget.isAnotherPost == true
                ?postArchiveController.dataAnotherPost[index].caption!
                :postArchiveController.data[index].caption!,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400),
              )),

          /// image post
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                itemCount:
                widget.isAnotherPost == true
                ?postArchiveController.dataAnotherPost[index].photoPath!.length
                :postArchiveController.data[index].photoPath!.length,
                builder: (BuildContext context, int indexPath) {
                  return PhotoViewGalleryPageOptions(
                      initialScale: PhotoViewComputedScale.covered,
                      minScale: PhotoViewComputedScale.covered * 0.95,
                      imageProvider: NetworkImage(Global.convertMedia(
                        widget.isAnotherPost==true
                          ?postArchiveController
                            .dataAnotherPost[index].photoPath![indexPath]
                          :postArchiveController
                              .data[index].photoPath![indexPath],
                          MediaQuery.of(context).size.width,
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
              )),

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
                              text:
                                  widget.isAnotherPost == true
                              ?postArchiveController.dataAnotherPost[index].totalLikes.toString()
                              :postArchiveController.data[index].totalLikes.toString(),
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
                              text:
                              widget.isAnotherPost==true
                              ?postArchiveController
                                  .dataAnotherPost[index].totalCmt == 0
                                  ? "0"
                                  : postArchiveController.dataAnotherPost[index].totalCmt.toString()
                              :postArchiveController
                                          .data[index].totalCmt == 0
                                  ? "0"
                                  : postArchiveController.data[index].totalCmt.toString(),
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
                    if(widget.isAnotherPost==true){
                      if (postArchiveController.dataAnotherPost[index].id.isNotEmpty) {
                        postArchiveController.postIdForLikePost =
                            postArchiveController.dataAnotherPost[index].id;
                        postArchiveController.handleLikeAnotherPost();
                      }
                    }
                    else{
                      if (postArchiveController.data[index].id.isNotEmpty) {
                        postArchiveController.postIdForLikePost =
                            postArchiveController.data[index].id;
                        postArchiveController.handleLikePost();
                      }
                    }

                  },
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.isAnotherPost == true
                          ?(postArchiveController.dataAnotherPost[index].liked == true)
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
                          )
                          :(postArchiveController.data[index].liked == true)
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
                      if(widget.isAnotherPost==true){
                        if (postArchiveController.dataAnotherPost[index].id.isNotEmpty) {
                          /// id using add cmt
                          Global.idPost = postArchiveController.dataAnotherPost[index].id;
                          ListCommentsPostRequest request =
                          ListCommentsPostRequest(
                              postArchiveController.dataAnotherPost[index].id);
                          postArchiveController.getListCommentsAnotherPost(request);
                        }
                      }
                      else{
                        if (postArchiveController.data[index].id.isNotEmpty) {
                          /// id using add cmt
                          Global.idPost = postArchiveController.data[index].id;
                          ListCommentsPostRequest request =
                          ListCommentsPostRequest(
                              postArchiveController.data[index].id);
                          postArchiveController.getListCommentsPost(request);
                        }
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

          const Divider()
        ],
      ),
    );
  }

  /// content list view post wireframe
  Widget skeleton() {
    return Container(
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
              ],
            ),
          ),

          /// caption of post
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey,
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.4))),
          ),

          /// image post
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                color: Colors.grey.withOpacity(0.4)),
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
                        borderRadius: BorderRadius.circular(5)),
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
                        borderRadius: BorderRadius.circular(5)),
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
                        borderRadius: BorderRadius.circular(5)),
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

  Widget detailBottomSheetMenuDot(
      PostArchiveController postArchiveController, index) {
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
                  onTap: () {},
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
                  onTap: () {},
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
                              if (Global.isAvailableToClick()) {
                                Navigator.pop(context);
                                postArchiveController.postIdForDeletePost =
                                    postArchiveController.data[index].id;
                                postArchiveController.handleDeletePost();
                              }
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
                              Global.userProfileResponse!.avatarPath,
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
                                  text: Global.userProfileResponse!.fullName,
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
