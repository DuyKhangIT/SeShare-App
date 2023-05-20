import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../api_http/handle_api.dart';
import '../../../models/list_another_post/data_another_post_response.dart';
import '../../../models/list_another_post/list_another_post_request.dart';
import '../../../models/list_another_post/list_another_post_response.dart';
import '../../../models/list_posts_home/list_posts_home_response.dart';
import '../../../util/global.dart';
import '../../navigation_bar/navigation_bar_view.dart';

class AnOtherProfileController extends GetxController {
  List<String> listPhotos = [];
  String background = "";
  String avatar = "";
  String fullName = "";
  String bio = "";
  bool isLoading = false;
  List<DataAnotherPostResponse> dataAnotherPost = [];
  @override
  void onReady() {
    listPhotos = Global.listPhotoAnOtherUser;
    background = Global.anOtherUserProfileResponse!.backgroundPath!;
    avatar = Global.anOtherUserProfileResponse!.avatarPath!;
    fullName = Global.anOtherUserProfileResponse!.fullName;
    bio = Global.anOtherUserProfileResponse!.bio!;
    handleListAnotherPost();
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleListAnotherPost() {
    ListAnotherPostRequest listAnotherPostRequest =
    ListAnotherPostRequest(Global.anOtherUserProfileResponse!.id);
    getListAnotherPosts(listAnotherPostRequest);
    update();
  }

  /// call api list post
  Future<ListPostsHomeResponse> getListPosts() async {
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
      debugPrint("------------- GET LIST POST SUCCESSFULLY--------------");
      Global.listPostInfo = listPostsHomeResponse.data!;
      Get.to(() => NavigationBarView(currentIndex: 0));
      update();
    }
    return listPostsHomeResponse;
  }

  Future<ListAnotherPostResponse> getListAnotherPosts(
      ListAnotherPostRequest listAnotherPostRequest) async {
    ListAnotherPostResponse listAnotherPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/get-list-another-posts"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(listAnotherPostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get list another posts $error");
      rethrow;
    }
    if (body == null) return ListAnotherPostResponse.buildDefault();
    //get data from api here
    listAnotherPostResponse = ListAnotherPostResponse.fromJson(body);
    if (listAnotherPostResponse.status == true) {
      debugPrint(
          "------------- GET LIST ANOTHER POSTS SUCCESSFULLY--------------");
      dataAnotherPost = listAnotherPostResponse.data!;
      update();
    }
    return listAnotherPostResponse;
  }
}
