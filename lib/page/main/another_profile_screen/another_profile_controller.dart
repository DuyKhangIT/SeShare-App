import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:instagram_app/models/add_friend/add_friend_request.dart';
import 'package:instagram_app/models/add_friend/add_friend_response.dart';
import 'package:instagram_app/models/deny_or_unfriend/deny_or_unfriend_request.dart';
import 'package:instagram_app/models/deny_or_unfriend/deny_or_unfriend_response.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../../../api_http/handle_api.dart';
import '../../../models/another_user_profile/another_profile_response.dart';
import '../../../models/another_user_profile/another_user_profile_request.dart';
import '../../../models/list_another_post/data_another_post_response.dart';
import '../../../models/list_another_post/list_another_post_request.dart';
import '../../../models/list_another_post/list_another_post_response.dart';
import '../../../models/list_my_friend/list_my_friend_response.dart';
import '../../../models/list_posts_home/list_posts_home_response.dart';
import '../../../util/global.dart';
import '../../navigation_bar/navigation_bar_view.dart';

class AnOtherProfileController extends GetxController {
  bool isLoading = false;
  ScreenshotController screenShotController = ScreenshotController();
  Uint8List? imageFile;
  String qrFilePath = "";
  List<DataAnotherPostResponse> dataAnotherPost = [];
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveImage(String file) async {
    await [Permission.storage].request();
    await ImageGallerySaver.saveFile(file);
  }

  void handleDenyOrUnfriend() {
    DenyOrUnfriendRequest denyOrUnfriendRequest =
        DenyOrUnfriendRequest(Global.anOtherUserProfileResponse!.id);
    denyOrUnfriend(denyOrUnfriendRequest);
    update();
  }

  void handleAddFriend() {
    AddFriendRequest addFriendRequest =
        AddFriendRequest(Global.anOtherUserProfileResponse!.id);
    addFriend(addFriendRequest);
    update();
  }

  void loadAnotherProfile() {
    AnotherUserProfileRequest anotherProfileRequest =
        AnotherUserProfileRequest(Global.userIdFromIndexPost);
    loadAnotherUserProfile(anotherProfileRequest);
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

  Future<DenyOrUnfriendResponse> denyOrUnfriend(
      DenyOrUnfriendRequest denyOrUnfriendRequest) async {
    DenyOrUnfriendResponse denyOrUnfriendResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/friends/deny-or-unfriend"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(denyOrUnfriendRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to deny or unfriend $error");
      rethrow;
    }
    if (body == null) return DenyOrUnfriendResponse.buildDefault();
    //get data from api here
    denyOrUnfriendResponse = DenyOrUnfriendResponse.fromJson(body);
    if (denyOrUnfriendResponse.status == true) {
      debugPrint("------------- UNFRIEND SUCCESSFULLY--------------");
      loadAnotherProfile();
      getListMyFriend();
      update();
    }
    return denyOrUnfriendResponse;
  }

  Future<AddFriendResponse> addFriend(AddFriendRequest addFriendRequest) async {
    AddFriendResponse addFriendResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/friends/send-request"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(addFriendRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to deny or unfriend $error");
      rethrow;
    }
    if (body == null) return AddFriendResponse.buildDefault();
    //get data from api here
    addFriendResponse = AddFriendResponse.fromJson(body);
    if (addFriendResponse.status == true) {
      debugPrint("------------- ADD FRIEND SUCCESSFULLY--------------");
      loadAnotherProfile();
      update();
    }
    return addFriendResponse;
  }

  /// load another user profile
  Future<AnOtherProfileResponse> loadAnotherUserProfile(
      AnotherUserProfileRequest anotherUserProfileRequest) async {
    AnOtherProfileResponse anOtherProfileResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/user/another-profile"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(anotherUserProfileRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to user profile $error");
      rethrow;
    }
    if (body == null) return AnOtherProfileResponse.buildDefault();
    //get data from api here
    anOtherProfileResponse = AnOtherProfileResponse.fromJson(body);
    if (anOtherProfileResponse.status == true) {
      Global.anOtherUserProfileResponse =
          anOtherProfileResponse.anOtherUserProfileResponse;
      debugPrint(
          "-------------  LOAD ANOTHER USER PROFILE SUCCESSFULLY -------------");
      update();
    } else {
      debugPrint("Lỗi api");
    }
    return anOtherProfileResponse;
  }

  /// call api list my friend
  Future<ListMyFriendResponse> getListMyFriend() async {
    ListMyFriendResponse listMyFriendResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/friends/list-friends"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list my friend $error");
      rethrow;
    }
    if (body == null) return ListMyFriendResponse.buildDefault();
    //get data from api here
    listMyFriendResponse = ListMyFriendResponse.fromJson(body);
    if (listMyFriendResponse.status == true) {
      debugPrint("------------- GET LIST MY FRIEND SUCCESSFULLY--------------");
      Global.dataFriend = listMyFriendResponse.data;
      update();
    }
    return listMyFriendResponse;
  }
}
