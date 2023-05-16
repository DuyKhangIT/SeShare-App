import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/delete_story/delete_story_request.dart';
import 'package:instagram_app/models/delete_story/delete_story_response.dart';

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


  /// handle delete post api
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
      //getListPosts();
      debugPrint("------------- DELETE STORY SUCCESSFULLY -------------");
      update();
    }
    return deleteStoryResponse;
  }
}
