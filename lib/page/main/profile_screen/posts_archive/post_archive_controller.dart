import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/list_my_post/data_my_post_response.dart';
import 'package:instagram_app/models/list_my_post/list_my_post_response.dart';


import '../../../../api_http/handle_api.dart';
import '../../../../models/delete_post/delete_post_request.dart';
import '../../../../models/delete_post/delete_post_response.dart';
import '../../../../models/like_post/like_post_request.dart';
import '../../../../models/like_post/like_post_response.dart';
import '../../../../models/list_comments_post/list_comments_post_request.dart';
import '../../../../models/list_comments_post/list_comments_post_response.dart';
import '../../../../util/global.dart';
import '../../home_screen/comments_screen/comments_view.dart';

class PostArchiveController extends GetxController {
  bool isLoading = true;
  List<DataMyPostResponse> data = [];
  String postIdForLikePost = "";
  String postIdForDeletePost = "";
  @override
  void onReady() {
    getListMyPosts();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  /// call api list post
  Future<ListMyPostResponse> getListMyPosts() async {
    isLoading = true;
    update();
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
      data = listMyPostResponse.data!;
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listMyPostResponse;
  }

  /// call api list post
  Future<ListMyPostResponse> getListMyPostsWhenLiked() async {
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
      data = listMyPostResponse.data!;
      update();
    }
    return listMyPostResponse;
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
      getListMyPostsWhenLiked();
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
      Get.to(() => CommentScreen(isMyPost: true));
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
      getListMyPosts();
      debugPrint("------------- DELETE POST SUCCESSFULLY -------------");
      update();
    }
    return deletePostsResponse;
  }
}
