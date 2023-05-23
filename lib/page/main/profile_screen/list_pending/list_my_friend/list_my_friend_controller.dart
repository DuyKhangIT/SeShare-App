import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/list_my_friend/list_my_friend_response.dart';

import '../../../../../api_http/handle_api.dart';
import '../../../../../models/another_user_profile/another_profile_response.dart';
import '../../../../../models/another_user_profile/another_user_profile_request.dart';
import '../../../../../models/deny_or_unfriend/deny_or_unfriend_request.dart';
import '../../../../../models/deny_or_unfriend/deny_or_unfriend_response.dart';
import '../../../../../models/get_all_photo_another_user/get_all_photo_another_user_request.dart';
import '../../../../../models/get_all_photo_another_user/get_all_photo_another_user_response.dart';
import '../../../../../models/list_favorite_stories_another_user/list_favorite_stories_another_user_request.dart';
import '../../../../../models/list_favorite_stories_another_user/list_favorite_stories_another_user_response.dart';
import '../../../../../models/list_my_friend/data_list_my_friend_response.dart';
import '../../../../../util/global.dart';
import '../../../../navigation_bar/navigation_bar_view.dart';
import '../../../another_profile_screen/another_profile_screen.dart';

class ListMyFriendController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String inputSearch = "";
  String userIdForLoadListAnotherProfile = "";
  bool isSearching = false;
  bool isLoading = false;
  List<DataListMyFriendResponse> data = [];
  List<DataListMyFriendResponse> result = [];
  @override
  void onReady() {
    getListMyFriend();
    update();
    super.onReady();
  }


  @override
  void onClose() {
    super.onClose();
  }

  void clearTextSearch() {
    inputSearch = "";
    searchController.clear();
    update();
  }

  /// searching
  void updateSearch(String value) {
    result = data
        .where((element) => Global()
            .accentParser(element.recipientObjectResponse!.fullName)
            .toLowerCase()
            .contains(Global().accentParser(value).toLowerCase()))
        .toList();
    isSearching = value.isNotEmpty;
    update();
  }

  /// call api list my friend
  Future<ListMyFriendResponse> getListMyFriend() async {
    isLoading = true;
    update();
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
      data = listMyFriendResponse.data;
      result = data;
      Global.dataFriend = listMyFriendResponse.data;
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listMyFriendResponse;
  }

  /// unfriend
  Future<DenyOrUnfriendResponse> denyOrUnfriend(
      DenyOrUnfriendRequest denyOrUnfriendRequest) async {
    DenyOrUnfriendResponse denyOrUnfriendResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/friends/deny-or-unfriend"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(denyOrUnfriendRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to deny or unfriend $error");
      rethrow;
    }
    if (body == null) return DenyOrUnfriendResponse.buildDefault();
    //get data from api here
    denyOrUnfriendResponse = DenyOrUnfriendResponse.fromJson(body);
    if (denyOrUnfriendResponse.status == true) {
      debugPrint(
          "------------- UNFRIEND SUCCESSFULLY--------------");
      getListMyFriend();
      update();
    }
    return denyOrUnfriendResponse;
  }

  void loadListPhotoAnotherUser() {
    GetAllPhotoAnotherUserRequest anotherUserRequest =
    GetAllPhotoAnotherUserRequest(userIdForLoadListAnotherProfile);
    getListPhotoAnOtherUser(anotherUserRequest);
    update();
    loadAnotherProfile();
  }

  void loadAnotherProfile() {
    AnotherUserProfileRequest anotherProfileRequest =
    AnotherUserProfileRequest(userIdForLoadListAnotherProfile);
    loadAnotherUserProfile(anotherProfileRequest);
    update();
    loadListFavoriteStoriesAnotherUser();
  }

  void loadListFavoriteStoriesAnotherUser() {
    ListFavoriteStoriesAnotherUserRequest
    listFavoriteStoriesAnotherUserRequest =
    ListFavoriteStoriesAnotherUserRequest(userIdForLoadListAnotherProfile);
    getListFavoriteStoriesAnotherUser(listFavoriteStoriesAnotherUserRequest);
    update();
  }


  /// call api list photo another user
  Future<GetAllPhotoAnOtherUserResponse> getListPhotoAnOtherUser(
      GetAllPhotoAnotherUserRequest getAllPhotoAnotherUserRequest) async {
    GetAllPhotoAnOtherUserResponse getAllPhotoAnOtherUserResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/get-list-photos-another-user"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(getAllPhotoAnotherUserRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get list photos another user $error");
      rethrow;
    }
    if (body == null) return GetAllPhotoAnOtherUserResponse.buildDefault();
    //get data from api here
    getAllPhotoAnOtherUserResponse =
        GetAllPhotoAnOtherUserResponse.fromJson(body);
    if (getAllPhotoAnOtherUserResponse.status == true) {
      debugPrint(
          "------------- GET LIST PHOTOS ANOTHER USER SUCCESSFULLY -------------");
      Global.listPhotoAnOtherUser =
      getAllPhotoAnOtherUserResponse.listPhotosUser!;
    }
    return getAllPhotoAnOtherUserResponse;
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

  /// call api list favorite stories another user
  Future<ListFavoriteStoriesAnotherUserResponse>
  getListFavoriteStoriesAnotherUser(
      ListFavoriteStoriesAnotherUserRequest
      listFavoriteStoriesAnotherUserRequest) async {
    ListFavoriteStoriesAnotherUserResponse listFavoriteStoriesAnotherUserResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/story/get-another-favorite"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(listFavoriteStoriesAnotherUserRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get list favorite stories $error");
      rethrow;
    }
    if (body == null) return ListFavoriteStoriesAnotherUserResponse.buildDefault();
    //get data from api here
    listFavoriteStoriesAnotherUserResponse =
        ListFavoriteStoriesAnotherUserResponse.fromJson(body);
    if (listFavoriteStoriesAnotherUserResponse.status == true) {
      debugPrint(
          "------------- GET LIST FAVORITE STORIES ANOTHER USER SUCCESSFULLY -------------");
      Global.listFavoriteStoriesAnotherUser = listFavoriteStoriesAnotherUserResponse.data!.stories!;
      Get.to(() => AnOtherProfileScreen(isMyFriendPage: true));
      update();
    } else {
      debugPrint("------------- ERROR API-------------");
    }
    return listFavoriteStoriesAnotherUserResponse;
  }
}
