import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/delete_story/delete_story_request.dart';
import 'package:instagram_app/models/delete_story/delete_story_response.dart';
import 'package:instagram_app/models/favorite_story/favorite_story_request.dart';
import 'package:instagram_app/models/favorite_story/favorite_story_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../navigation_bar/navigation_bar_view.dart';

class StoryController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  /// handle delete story api
  Future<DeleteStoryResponse> deleteStory(
      DeleteStoryRequest deleteStoryRequest) async {
    DeleteStoryResponse deleteStoryResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/story/delete-story"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(deleteStoryRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to delete story $error");
      rethrow;
    }
    if (body == null) return DeleteStoryResponse.buildDefault();
    //get data from api here
    deleteStoryResponse = DeleteStoryResponse.fromJson(body);
    if (deleteStoryResponse.status == true) {
      Get.offAll(() => NavigationBarView(currentIndex: 0));
      debugPrint("------------- DELETE STORY SUCCESSFULLY -------------");
      update();
    }
    return deleteStoryResponse;
  }

  /// handle favorite story api
  Future<FavoriteStoryResponse> favoriteStory(FavoriteStoryRequest favoriteStoryRequest) async {
    FavoriteStoryResponse favoriteStoryResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/story/update-favorite"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(favoriteStoryRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to favorite story $error");
      rethrow;
    }
    if (body == null) return FavoriteStoryResponse.buildDefault();
    //get data from api here
    favoriteStoryResponse = FavoriteStoryResponse.fromJson(body);
    if (favoriteStoryResponse.status == true) {
      debugPrint("----------FAVORITE STORY SUCCESSFULLY----------");
      Get.offAll(() => NavigationBarView(currentIndex: 0));
      update();
    }
    return favoriteStoryResponse;
  }
}
