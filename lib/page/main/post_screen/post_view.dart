import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/post_screen/post_controller.dart';
import 'package:instagram_app/util/global.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../util/module.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    return GetBuilder<PostController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                centerTitle: true,
                title: Text(
                  "Tạo bài viết",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                actions: [
                  (postController.inputStatusController.text.isEmpty &&
                          postController.privacy.isEmpty &&
                          postController.avatar == null)
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color(0xffFFFFFF).withOpacity(0.4),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Đăng".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color(0xffFFFFFF).withOpacity(0.4),
                            ),
                            onPressed: () {
                              if (Global.isAvailableToClick()) {
                                postController.posts();
                              }
                            },
                            child: Text(
                              "Đăng".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                ],
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            /// avatar user
                            Container(
                                width: 55,
                                height: 55,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Global.userProfileResponse!.avatarPath!
                                          .isNotEmpty
                                      ? getNetworkImage(
                                          Global
                                              .userProfileResponse!.avatarPath,
                                          width: null,
                                          height: null)
                                      : Container(),
                                )),

                            /// name and current location user and policy
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.28,
                              height: 50,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        Global.userProfileResponse!.fullName,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      postController.privacy.isNotEmpty
                                          ? Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 92),
                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 2, 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.4))),
                                              child:

                                                  /// public
                                                  Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    postController.privacy ==
                                                            "public"
                                                        ? IconsAssets
                                                            .icPublicMode
                                                        : postController
                                                                    .privacy ==
                                                                "private"
                                                            ? IconsAssets
                                                                .icPrivateMode
                                                            : IconsAssets
                                                                .icFriendMode,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                        postController
                                                                    .privacy ==
                                                                "public"
                                                            ? "Công khai"
                                                            : postController
                                                                        .privacy ==
                                                                    "private"
                                                                ? "Cá nhân"
                                                                : "Bạn bè",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Nunito Sans')),
                                                  ),
                                                ],
                                              ))
                                          : const SizedBox()
                                    ],
                                  ),

                                  ///current location user
                                  (Global.currentLocation.isNotEmpty)
                                      ? Text(
                                          Global.currentLocation,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),

                        (postController.checkInPost.isNotEmpty)
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Image.asset(IconsAssets.icCheckIn),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      constraints: const BoxConstraints(
                                          maxWidth: 330, minHeight: 50),
                                      child: Text(
                                        "Địa điểm bạn nhắc tới: ${postController.checkInPost}",
                                        maxLines: 3,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        /// input status
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              constraints: const BoxConstraints(minHeight: 80),
                              padding: const EdgeInsets.only(left: 14),
                              child: TextField(
                                style: const TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                maxLines: null,
                                controller:
                                    postController.inputStatusController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                decoration: const InputDecoration(
                                  hintText: 'Bạn muốn chia sẻ điều gì hôm nay?',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  counterText: '',
                                ),
                                onChanged: (value) {
                                  postController.captionPost = value;
                                  postController.update();
                                },
                              ),
                            ),

                            /// list photo of user post
                            (postController.photoPath.isNotEmpty)
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 350,
                                    child: PhotoViewGallery.builder(
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      builder: (BuildContext context,
                                          int indexPath) {
                                        return PhotoViewGalleryPageOptions(
                                          initialScale:
                                              PhotoViewComputedScale.covered,
                                          minScale:
                                              PhotoViewComputedScale.covered,
                                          maxScale:
                                              PhotoViewComputedScale.covered,
                                          imageProvider: NetworkImage(
                                              Global.convertMedia(
                                                  postController
                                                      .photoPath[indexPath]
                                                      .toString(),
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  350)),
                                        );
                                      },
                                      itemCount:
                                          postController.photoPath.length,
                                    ))
                                : const SizedBox()
                          ],
                        ),

                        /// add image and add check in
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Thêm vào bài viết của bạn: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito Sans',
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return detailBottomSheetAddImage(
                                              postController);
                                        });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(IconsAssets.icAddImage,
                                        fit: BoxFit.cover,
                                        color: Colors.lightBlue),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    postController.captureData();
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child:
                                        Image.asset(IconsAssets.icLocationPost),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return detailBottomSheetPrivacy(
                                              postController);
                                        });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(IconsAssets.icPrivacy,
                                        color: Colors.deepPurpleAccent),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /// add image
  Widget detailBottomSheetAddImage(PostController postController) {
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
                    postController.getImageFromCamera();
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
                    postController.getImageFromGallery();
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

  /// choose policy
  Widget detailBottomSheetPrivacy(PostController postController) {
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
            children: [
              /// public mode
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            postController.isPublic.value =
                                !postController.isPublic.value;
                            postController.isPrivate.value = false;
                            postController.isFriend.value = false;
                            postController.update();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Text("Chế độ công khai".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ),
                          )),
                      postController.isPublic.value == true
                          ? Image.asset(IconsAssets.icChecked,
                              width: 20, height: 20)
                          : const SizedBox()
                    ],
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),

              /// private mode
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            postController.isPrivate.value =
                                !postController.isPrivate.value;
                            postController.isPublic.value = false;
                            postController.isFriend.value = false;
                            postController.update();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Text("Chế độ cá nhân".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ),
                          )),
                      postController.isPrivate.value == true
                          ? Image.asset(IconsAssets.icChecked,
                              width: 20, height: 20)
                          : const SizedBox()
                    ],
                  )),
              Divider(
                thickness: 0.5,
                height: 0,
                color: Colors.black.withOpacity(0.1),
              ),

              /// friend mode
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            postController.isFriend.value =
                                !postController.isFriend.value;
                            postController.isPrivate.value = false;
                            postController.isPublic.value = false;
                            postController.update();
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Text("Chế độ bạn bè".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            ),
                          )),
                      postController.isFriend.value == true
                          ? Image.asset(IconsAssets.icChecked,
                              width: 20, height: 20)
                          : const SizedBox()
                    ],
                  )),
            ],
          ),
        ),

        /// selected
        Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (postController.isPublic.value == true) {
                    postController.privacy = "public";
                  } else if (postController.isPrivate.value == true) {
                    postController.privacy = "private";
                  } else {
                    postController.privacy = "friends";
                  }
                  postController.update();
                  Navigator.pop(context);
                  debugPrint(postController.privacy);
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
                  "Chọn".toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2),
                ),
              ),
            )),

        /// BUTTON CANCEL
        Padding(
            padding: const EdgeInsets.only(bottom: 34, left: 34, right: 34),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  postController.isPublic.value = false;
                  postController.isPrivate.value = false;
                  postController.isFriend.value = false;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
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
