import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/post_screen/post_controller.dart';
import 'package:instagram_app/util/global.dart';

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
                  (postController.inputStatusController.text.isEmpty)
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
                ],
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
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
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    ImageAssets.imgTet,
                                    fit: BoxFit.cover,
                                  ),
                                )),

                            /// name and current location user
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.28,
                              height: 50,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Duy Khang",
                                    style: TextStyle(
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Text(
                                  "Địa điểm bạn nhắc tới: ${postController.checkInPost}",
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        /// input status
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20,top: 10),
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
                                  hintText: 'Bạn đang nghĩ gì?',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  counterText: '',
                                ),
                                onChanged: (value) {
                                  postController.statusPost = value;
                                  postController.update();
                                },
                              ),
                            ),
                            (postController.avatar != null)
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    child: Image.file(
                                      postController.avatar!,
                                      fit: BoxFit.cover,
                                    ))
                                : const SizedBox()
                          ],
                        ),

                        /// add image and changed address
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                                  child: Image.asset(IconsAssets.icAddImage,
                                      color: Colors.blue,
                                      width: 30,
                                      height: 30)),
                              const SizedBox(width: 20),
                              GestureDetector(
                                  onTap: () {
                                    postController.captureData();
                                  },
                                  child: Image.asset(IconsAssets.icLocationPost,
                                      width: 30, height: 30)),
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
              InkWell(
                  onTap: () {
                    postController.getImageFromCamera();
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
                    postController.getImageFromGallery();
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
