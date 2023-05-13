import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/list_posts_home/list_posts_home_response.dart';
import '../../../../models/update_post/update_post_request.dart';
import '../../../../models/update_post/update_post_response.dart';
import '../../../../util/global.dart';
import '../../../navigation_bar/navigation_bar_view.dart';

class UpdatePostController extends GetxController {
  TextEditingController inputCaptionController = TextEditingController();
  TextEditingController inputCheckInLocationController = TextEditingController();
  String captionPost = "";
  String checkInLocation = "";
  RxBool isPublic = false.obs;
  RxBool isPrivate = false.obs;
  RxBool isFriend = false.obs;
  String privacy = "";
  String postId = "";
  @override
  void onReady() {
    postId = Global.infoMyPost!.id;
    inputCaptionController.text = Global.infoMyPost!.caption!;
    inputCheckInLocationController.text = Global.infoMyPost!.checkInLocation;
    privacy = Global.infoMyPost!.privacy;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleUpdatePost(){
  UpdatePostRequest updatePostRequest = UpdatePostRequest(postId, inputCaptionController.text, inputCheckInLocationController.text, privacy);
  updatePost(updatePostRequest);
  update();
  }

  /// handle update post api
  Future<UpdatePostResponse> updatePost(UpdatePostRequest updatePostRequest) async {
    UpdatePostResponse updatePostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/update-post"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(updatePostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to update post $error");
      rethrow;
    }
    if (body == null) return UpdatePostResponse.buildDefault();
    //get data from api here
    updatePostResponse = UpdatePostResponse.fromJson(body);
    if (updatePostResponse.status == true) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Thành công!',
          message: "Chỉnh sửa thông tin thành công",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      updateListPosts();
      debugPrint("----------update post success----------");
      update();
    }
    return updatePostResponse;
  }

  /// call api update list post after cmt
  Future<ListPostsHomeResponse> updateListPosts() async {
    ListPostsHomeResponse listPostsHomeResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/homepage-posts"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list posts $error");
      rethrow;
    }
    if (body == null) return ListPostsHomeResponse.buildDefault();
    //get data from api here
    listPostsHomeResponse = ListPostsHomeResponse.fromJson(body);
    if (listPostsHomeResponse.status == true) {
      debugPrint("----------list post after update post---------");
      Global.listPostInfo = listPostsHomeResponse.data!;
      update();
      Get.to(() => NavigationBarView(currentIndex: 0));
    }
    return listPostsHomeResponse;
  }
}
