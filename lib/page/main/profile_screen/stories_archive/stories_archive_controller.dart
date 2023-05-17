import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/list_my_stories/data_list_my_stories_response.dart';
import 'package:instagram_app/models/list_my_stories/list_my_stories_response.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../util/global.dart';

class StoriesArchiveController extends GetxController {
  bool isLoading = true;
  List<DataListMyStoriesResponse> data = [];
  @override
  void onReady() {
    getListMyStories();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// call api list my stories
  Future<ListMyStoriesResponse> getListMyStories() async {
    isLoading = true;
    update();
    ListMyStoriesResponse listMyStoriesResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/story/all-my-stories"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list my stories $error");
      rethrow;
    }
    if (body == null) return ListMyStoriesResponse.buildDefault();
    //get data from api here
    listMyStoriesResponse = ListMyStoriesResponse.fromJson(body);
    if (listMyStoriesResponse.status == true) {
      debugPrint("------------- GET LIST MY STORIES SUCCESSFULLY--------------");
      data = listMyStoriesResponse.data!;
      Global.listMyStories = data;
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listMyStoriesResponse;
  }
}
