import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:instagram_app/models/delete_post/delete_post_request.dart';
import 'package:instagram_app/models/get_all_photo_another_user/get_all_photo_another_user_request.dart';
import 'package:instagram_app/models/get_all_photo_another_user/get_all_photo_another_user_response.dart';
import 'package:instagram_app/models/hide_comment_post/hide_comment_post_request.dart';
import 'package:instagram_app/models/hide_comment_post/hide_comment_post_response.dart';
import 'package:instagram_app/models/hide_like_post/hide_like_post_request.dart';
import 'package:instagram_app/models/hide_like_post/hide_like_post_response.dart';
import 'package:instagram_app/models/like_post/like_post_request.dart';
import 'package:instagram_app/models/like_post/like_post_response.dart';
import 'package:instagram_app/models/list_favorite_stories_another_user/list_favorite_stories_another_user_response.dart';
import 'package:instagram_app/models/list_my_favorite_stories/list_my_favorite_stories_response.dart';
import 'package:instagram_app/models/list_photos_search/list_photos_search_response.dart';

import 'package:instagram_app/models/list_posts_home/list_posts_home_response.dart';
import 'package:instagram_app/models/list_story/list_story_response.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../../api_http/handle_api.dart';
import '../../../models/another_user_profile/another_profile_response.dart';
import '../../../models/another_user_profile/another_user_profile_request.dart';
import '../../../models/delete_post/delete_post_response.dart';
import '../../../models/list_another_post/list_another_post_request.dart';
import '../../../models/list_another_post/list_another_post_response.dart';
import '../../../models/list_comments_post/list_comments_post_request.dart';
import '../../../models/list_comments_post/list_comments_post_response.dart';
import '../../../models/list_favorite_stories_another_user/list_favorite_stories_another_user_request.dart';
import '../../../models/list_my_friend/list_my_friend_response.dart';
import '../../../models/list_my_post/list_my_post_response.dart';
import '../../../models/user_profile/profile_response.dart';
import '../../../util/global.dart';
import '../another_profile_screen/another_profile_screen.dart';
import 'comments_screen/comments_view.dart';
import 'infor_account_screen/infro_account_view.dart';

class HomeController extends GetxController {
  ScreenshotController  screenShotController = ScreenshotController();
  Uint8List? imageFile;
  String qrFilePath = "";
  File? avatar;
  bool isNewUpdate = false;
  String userId = "";
  bool isLoading = false;
  String phone = "";
  bool isLike = false;
  bool hideLike = false;
  bool hideCmt = false;
  bool loadingAnotherPost = false;
  bool loadingAnotherProfileInForAccountScreen = false;
  String userIdForLoadListAnotherProfile = "";
  String postIdForLikePost = "";
  String postIdForDeletePost = "";

  @override
  void onReady() {
    getListPosts();
    getListStories();
    loadUserProfile();
    getListPhotoSearch();
    getListMyFavoriteStories();
    getListMyFriend();
    getListMyPosts();

    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveImage(String file) async{
    await [Permission.storage].request();
    await ImageGallerySaver.saveFile(file);
  }

  void handleListAnotherPost() {
    ListAnotherPostRequest listAnotherPostRequest =
    ListAnotherPostRequest(Global.anOtherUserProfileResponse!.id);
    getListAnotherPosts(listAnotherPostRequest);
    update();
    //loadListFavoriteStoriesAnotherUser();
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
    loadingAnotherPost = true;
    update();
  }

  void loadAnotherProfileForInfoAnotherUser() {
    AnotherUserProfileRequest anotherProfileRequest =
        AnotherUserProfileRequest(userIdForLoadListAnotherProfile);
    loadAnotherUserProfile(anotherProfileRequest);
    loadingAnotherProfileInForAccountScreen = true;
    update();
  }

  void handleLikePost() {
    LikePostRequest likePostRequest = LikePostRequest(postIdForLikePost);
    likePost(likePostRequest);
    update();
  }

  void handleDeletePost() {
    DeletePostRequest deletePostRequest =
        DeletePostRequest(postIdForDeletePost);
    deletePost(deletePostRequest);
    update();
  }

  void loadListFavoriteStoriesAnotherUser() {
    ListFavoriteStoriesAnotherUserRequest
        listFavoriteStoriesAnotherUserRequest =
        ListFavoriteStoriesAnotherUserRequest(userIdForLoadListAnotherProfile);
    getListFavoriteStoriesAnotherUser(listFavoriteStoriesAnotherUserRequest);
    update();
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

  /// call api list post
  Future<ListPostsHomeResponse> getListPosts() async {
    isLoading = true;
    update();
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
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listPostsHomeResponse;
  }

  /// call api list post when liked
  Future<ListPostsHomeResponse> getListPostsWhenLiked() async {
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
      //dataPostsResponse = listPostsHomeResponse.data!;
      Global.listPostInfo = listPostsHomeResponse.data!;
      update();
    }
    return listPostsHomeResponse;
  }

  // /// refresh
  Future<void> refreshData() async {
    isNewUpdate = false;
    update();
    getListPosts();
    getListStories();
    getListPhotoSearch();
    getListMyFriend();
    getListMyPosts();
  }

  /// pull to refresh
  Future<void> pullToRefreshData({bool isRefreshIndicator = true}) async {
    isNewUpdate = false;
    getListPosts();
    getListStories();
    getListPhotoSearch();
    getListMyFriend();
    getListMyPosts();
    update();
    return Future.delayed(const Duration(seconds: 1));
  }

  /// load user profile
  Future<ProfileResponse> loadUserProfile() async {
    ProfileResponse profileResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/user/profile"),
          RequestType.post,
          headers: null,
          body: null);
      debugPrint("------------- RESTFULL API USER PROFILE -------------");
    } catch (error) {
      debugPrint("Fail to user profile $error");
      rethrow;
    }
    if (body == null) return ProfileResponse.buildDefault();
    //get data from api here
    profileResponse = ProfileResponse.fromJson(body);
    if (profileResponse.status == true) {
      Global.userProfileResponse = profileResponse.userProfileResponse;
      debugPrint("------------- LOAD USER PROFILE SUCCESSFULLY -------------");
      update();
    }
    return profileResponse;
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
      debugPrint("-------------  LOAD ANOTHER USER PROFILE SUCCESSFULLY -------------");
      Global.anOtherUserProfileResponse = anOtherProfileResponse.anOtherUserProfileResponse;
      update();
      if(loadingAnotherPost == true){
        handleListAnotherPost();
        loadingAnotherPost = false;
        update();
      }else if(loadingAnotherProfileInForAccountScreen == true){
        Get.to(() => InForAccountScreen(isMyAccount: false));
        loadingAnotherProfileInForAccountScreen = false;
        update();
      }
    } else {
      debugPrint("Lỗi api");
    }
    return anOtherProfileResponse;
  }

  /// handle like post api
  Future<LikePostResponse> likePost(LikePostRequest likePostRequest) async {
    LikePostResponse likePostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/like"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(likePostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to user profile $error");
      rethrow;
    }
    if (body == null) return LikePostResponse.buildDefault();
    //get data from api here
    likePostResponse = LikePostResponse.fromJson(body);
    if (likePostResponse.status == true) {
      getListPostsWhenLiked();
      debugPrint("----------LIKE POST SUCCESSFULLY----------");
      update();
    }
    return likePostResponse;
  }

  /// call api list comment post
  Future<ListCommentsPostResponse> getListCommentsPost(
      ListCommentsPostRequest request) async {
    ListCommentsPostResponse listCommentsPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/list-comment-of-post"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(request.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to get list cmt $error");
      rethrow;
    }
    if (body == null) return ListCommentsPostResponse.buildDefault();
    //get data from api here
    listCommentsPostResponse = ListCommentsPostResponse.fromJson(body);
    if (listCommentsPostResponse.status == true) {
      debugPrint(
          "------------- GET LIST COMMENT POST SUCCESSFULLY -------------");
      Global.dataListCmt = listCommentsPostResponse.data;
      update();
      Get.to(() => CommentScreen());
    }
    return listCommentsPostResponse;
  }

  /// handle delete post api
  Future<DeletePostResponse> deletePost(
      DeletePostRequest deletePostRequest) async {
    DeletePostResponse deletePostsResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/delete-post"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(deletePostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to delete post $error");
      rethrow;
    }
    if (body == null) return DeletePostResponse.buildDefault();
    //get data from api here
    deletePostsResponse = DeletePostResponse.fromJson(body);
    if (deletePostsResponse.status == true) {
      Navigator.pop(Get.context!);
      getListPosts();
      debugPrint("------------- DELETE POST SUCCESSFULLY -------------");
      update();
    }
    return deletePostsResponse;
  }

  /// call api list story
  Future<ListStoryResponse> getListStories() async {
    isLoading = true;
    update();
    ListStoryResponse listStoryResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/story/home-page-stories"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list stories $error");
      rethrow;
    }
    if (body == null) return ListStoryResponse.buildDefault();
    //get data from api here
    listStoryResponse = ListStoryResponse.fromJson(body);
    if (listStoryResponse.status == true) {
      debugPrint("------------- GET LIST STORIES SUCCESSFULLY -------------");
      Global.listStoriesData = listStoryResponse.data!;
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listStoryResponse;
  }

  /// call api list my favorite stories
  Future<ListMyFavoriteStoriesResponse> getListMyFavoriteStories() async {
    ListMyFavoriteStoriesResponse listMyFavoriteStoriesResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/story/get-my-favorite"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list my favorite stories $error");
      rethrow;
    }
    if (body == null) return ListMyFavoriteStoriesResponse.buildDefault();
    //get data from api here
    listMyFavoriteStoriesResponse = ListMyFavoriteStoriesResponse.fromJson(body);
    if (listMyFavoriteStoriesResponse.status == true) {
      debugPrint(
          "------------- GET LIST MY FAVORITE STORIES SUCCESSFULLY -------------");
      Global.listMyFavoriteStories = listMyFavoriteStoriesResponse.data!.stories!;
      update();
    } else {
      debugPrint("------------- ERROR API-------------");
    }
    return listMyFavoriteStoriesResponse;
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
      Get.to(() =>  AnOtherProfileScreen());
    } else {
      debugPrint("------------- ERROR API-------------");
    }
    return listFavoriteStoriesAnotherUserResponse;
  }

  /// call api list post
  Future<ListMyPostResponse> getListMyPosts() async {
    ListMyPostResponse listMyPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/get-list-my-posts"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list my posts $error");
      rethrow;
    }
    if (body == null) return ListMyPostResponse.buildDefault();
    //get data from api here
    listMyPostResponse = ListMyPostResponse.fromJson(body);
    if (listMyPostResponse.status == true) {
      debugPrint("------------- GET LIST MY POSTS SUCCESSFULLY--------------");
      Global.listMyPost = listMyPostResponse.data!;
      update();
    }
    return listMyPostResponse;
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
      Global.listAnotherPost = listAnotherPostResponse.data!;
      loadListFavoriteStoriesAnotherUser();
      update();
    }
    return listAnotherPostResponse;
  }


  /// handle hide like post api
  Future<HideLikePostResponse> hideLikePost(HideLikePostRequest hideLikePostRequest) async {
    HideLikePostResponse hideLikePostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/hidden-like"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(hideLikePostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to hide like post $error");
      rethrow;
    }
    if (body == null) return HideLikePostResponse.buildDefault();
    //get data from api here
    hideLikePostResponse = HideLikePostResponse.fromJson(body);
    if (hideLikePostResponse.status == true) {
      getListPostsWhenLiked();
      debugPrint("----------HIDE LIKE POST SUCCESSFULLY----------");
      update();
    }
    return hideLikePostResponse;
  }

  /// handle hide cmt post api
  Future<HideCommentPostResponse> hideCmtPost(HideCommentPostRequest hideCommentPostRequest) async {
    HideCommentPostResponse hideCommentPostResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/photo/hidden-comment"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(hideCommentPostRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to hide comment post $error");
      rethrow;
    }
    if (body == null) return HideCommentPostResponse.buildDefault();
    //get data from api here
    hideCommentPostResponse = HideCommentPostResponse.fromJson(body);
    if (hideCommentPostResponse.status == true) {
      getListPostsWhenLiked();
      debugPrint("----------HIDE COMMENT POST SUCCESSFULLY----------");
      update();
    }
    return hideCommentPostResponse;
  }

  /// call api list photo search
  Future<ListPhotosSearchResponse> getListPhotoSearch() async {
    ListPhotosSearchResponse listPhotosSearchResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/filter/populate"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list photos search $error");
      rethrow;
    }
    if (body == null) return ListPhotosSearchResponse.buildDefault();
    //get data from api here
    listPhotosSearchResponse = ListPhotosSearchResponse.fromJson(body);
    if (listPhotosSearchResponse.status == true) {
      debugPrint("------------- GET LIST PHOTOS SEARCH SUCCESSFULLY -------------");
      Global.listPhotosSearch = listPhotosSearchResponse.data;
      update();
    }
    return listPhotosSearchResponse;
  }
}
