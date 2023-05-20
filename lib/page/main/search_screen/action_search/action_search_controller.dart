import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/search_user/data_search_user_response.dart';
import 'package:instagram_app/models/search_user/search_user_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/another_user_profile/another_profile_response.dart';
import '../../../../models/another_user_profile/another_user_profile_request.dart';
import '../../../../models/get_all_photo_another_user/get_all_photo_another_user_request.dart';
import '../../../../models/get_all_photo_another_user/get_all_photo_another_user_response.dart';
import '../../../../models/list_favorite_stories_another_user/list_favorite_stories_another_user_request.dart';
import '../../../../models/list_favorite_stories_another_user/list_favorite_stories_another_user_response.dart';
import '../../../../util/global.dart';
import '../../another_profile_screen/another_profile_screen.dart';

class ActionSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String inputSearch = "";
  String userIdForLoadListAnotherProfile = "";
  bool isSearching = false;
  bool isLoading = false;
  List<DataSearchUserResponse> dataAllUser = [];
  List<DataSearchUserResponse> result = [];
  @override
  void onReady() {
    searchUser();
    result = dataAllUser;
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
    result = dataAllUser
        .where((element) => Global().accentParser(element.fullName)
        .toLowerCase()
        .contains(Global().accentParser(value).toLowerCase()))
        .toList();
    isSearching = value.isNotEmpty;
    update();
  }


  /// call api list post
  Future<SearchUserResponse> searchUser() async {
    isSearching = true;
    update();
    SearchUserResponse searchUserResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/filter/search"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to search user api $error");
      rethrow;
    }
    if (body == null) return SearchUserResponse.buildDefault();
    //get data from api here
    searchUserResponse = SearchUserResponse.fromJson(body);
    if (searchUserResponse.status == true) {
      debugPrint("------------- SEARCH USER API SUCCESSFULLY--------------");
      dataAllUser = searchUserResponse.data!;
      await Future.delayed(const Duration(seconds: 1), () {});
      isSearching = false;
      update();
    }
    return searchUserResponse;
  }

  void loadListPhotoAnotherUser() {
    GetAllPhotoAnotherUserRequest anotherUserRequest =
    GetAllPhotoAnotherUserRequest(userIdForLoadListAnotherProfile);
    getListPhotoAnOtherUser(anotherUserRequest);
    update();
  }

  void loadAnotherProfile() {
    AnotherUserProfileRequest anotherProfileRequest =
    AnotherUserProfileRequest(userIdForLoadListAnotherProfile);
    loadAnotherUserProfile(anotherProfileRequest);
    update();
  }

  void loadListFavoriteStoriesAnotherUser() {
    ListFavoriteStoriesAnotherUserRequest
    listFavoriteStoriesAnotherUserRequest =
    ListFavoriteStoriesAnotherUserRequest(userIdForLoadListAnotherProfile);
    getListFavoriteStoriesAnotherUser(listFavoriteStoriesAnotherUserRequest);
    update();
    if (Global.listFavoriteStoriesAnotherUser.isNotEmpty) {
      Get.to(() => const AnOtherProfileScreen());
    }
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
      update();
    } else {
      debugPrint("------------- ERROR API-------------");
    }
    return listFavoriteStoriesAnotherUserResponse;
  }
}
