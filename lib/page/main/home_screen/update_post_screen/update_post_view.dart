import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/home_screen/update_post_screen/update_post_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../util/global.dart';
import '../../../../util/module.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  @override
  Widget build(BuildContext context) {
    UpdatePostController updatePostController =
        Get.put(UpdatePostController());
    return GetBuilder<UpdatePostController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    updatePostController.updateListPosts();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                title: Text(
                  "Chỉnh sửa thông tin",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (Global.isAvailableToClick()) {
                          updatePostController.handleUpdatePost();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                ],
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                    child: Global.infoMyPost!.userInfoResponse!
                                        .avatar.isNotEmpty
                                        ? SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: getNetworkImage(
                                              Global.infoMyPost!
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
                                            Global.infoMyPost!.userInfoResponse!
                                                .fullName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontFamily: 'Nunito Sans')),

                                        /// privacy mode
                                        GestureDetector(
                                          onTap: (){
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return detailBottomSheetPrivacy(
                                                      updatePostController);
                                                });
                                          },
                                          child: Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 115),
                                              margin: const EdgeInsets.only(
                                                  top: 5),
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  5, 5, 2, 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.4))),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Image.asset(
                                                    updatePostController.privacy ==
                                                        "public"
                                                        ? IconsAssets
                                                        .icPublicMode
                                                        : updatePostController.privacy ==
                                                        "private"
                                                        ? IconsAssets
                                                        .icPrivateMode
                                                        : IconsAssets
                                                        .icFriendMode,
                                                    width: 14,
                                                    height: 14,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    margin: const EdgeInsets.only(left: 8),
                                                    child: Text(
                                                        updatePostController.privacy ==
                                                            "public"
                                                            ? "Công khai"
                                                            : updatePostController.privacy ==
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
                                                  const Icon(Icons.arrow_drop_down)
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                        (Global.infoMyPost!.checkInLocation.isNotEmpty)
                            ? Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Image.asset(
                                  IconsAssets.icCheckIn,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 1.25,
                                  constraints: const BoxConstraints(maxHeight: 60),
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  style: const TextStyle(
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                  maxLines: null,
                                  controller:
                                  updatePostController.inputCheckInLocationController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.grey,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    counterText: '',
                                  ),
                                  onChanged: (value) {
                                    updatePostController.checkInLocation = value;
                                    updatePostController.update();
                                  },
                                ),
                              )
                              // Container(
                              //   width: MediaQuery.of(context).size.width / 1.4,
                              //   constraints: const BoxConstraints(maxHeight: 40),
                              //   alignment: Alignment.centerLeft,
                              //   margin: const EdgeInsets.only(left: 5),
                              //   child: Text(
                              //       overflow: TextOverflow.ellipsis,
                              //       "Địa điểm bạn nhắc tới: ${Global.infoMyPost!.checkInLocation}",
                              //       maxLines: 2,
                              //       style: const TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 12,
                              //           fontFamily: 'Nunito Sans')),
                              // ),
                            ],
                          ),
                        )
                            : Container(),

                        /// input caption
                        Container(
                          margin:
                          const EdgeInsets.only(top: 10),
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
                            updatePostController.inputCaptionController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              updatePostController.captionPost = value;
                              updatePostController.update();
                            },
                          ),
                        ),

                        /// image post
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            child: PhotoViewGallery.builder(
                              scrollPhysics: const BouncingScrollPhysics(),
                              itemCount: Global.infoMyPost!.photoPath!.length,
                              builder: (BuildContext context, int indexPath) {
                                return PhotoViewGalleryPageOptions(
                                    initialScale: PhotoViewComputedScale.covered,
                                    minScale: PhotoViewComputedScale.covered * 0.95,
                                    imageProvider: NetworkImage(Global.convertMedia(
                                        Global.infoMyPost!.photoPath![indexPath]
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
                            )),


                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /// choose policy
  Widget detailBottomSheetPrivacy(UpdatePostController updatePostController) {
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
                        updatePostController.isPublic.value =
                        !updatePostController.isPublic.value;
                        updatePostController.isPrivate.value = false;
                        updatePostController.isFriend.value = false;
                        updatePostController.update();
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
                  updatePostController.isPublic.value == true
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
                        updatePostController.isPrivate.value =
                        !updatePostController.isPrivate.value;
                        updatePostController.isPublic.value = false;
                        updatePostController.isFriend.value = false;
                        updatePostController.update();
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
                  updatePostController.isPrivate.value == true
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
                        updatePostController.isFriend.value =
                        !updatePostController.isFriend.value;
                        updatePostController.isPrivate.value = false;
                        updatePostController.isPublic.value = false;
                        updatePostController.update();
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
                  updatePostController.isFriend.value == true
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
                  if (updatePostController.isPublic.value == true) {
                    updatePostController.privacy = "public";
                  } else if (updatePostController.isPrivate.value == true) {
                    updatePostController.privacy = "private";
                  } else {
                    updatePostController.privacy = "friends";
                  }
                  updatePostController.update();
                  Navigator.pop(context);
                  debugPrint(updatePostController.privacy);
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
                  updatePostController.isPublic.value = false;
                  updatePostController.isPrivate.value = false;
                  updatePostController.isFriend.value = false;
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
