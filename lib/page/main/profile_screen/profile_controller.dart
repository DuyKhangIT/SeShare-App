import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/models/get_all_photo_user/get_all_photo_user_response.dart';

import '../../../api_http/handle_api.dart';
import '../../../models/list_my_pending/list_my_pending_response.dart';
import '../../../models/list_my_post/data_my_post_response.dart';
import '../../../models/list_my_post/list_my_post_response.dart';
import '../../../util/global.dart';
import 'list_pending/list_peding_view.dart';

class ProfileController extends GetxController {
  List<DataMyPostResponse> data = [];

  @override
  void onReady() {
    getListPhotoUser();
    getListMyPosts();
    update();
    super.onReady();
  }


  @override
  void onClose() {
    super.onClose();
  }

  /// call api list post
  Future<GetAllPhotoUserResponse> getListPhotoUser() async {
    GetAllPhotoUserResponse getAllPhotoUserResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:8080/api/photo/get-list-photos-user"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list photos $error");
      rethrow;
    }
    if (body == null) return GetAllPhotoUserResponse.buildDefault();
    //get data from api here
    getAllPhotoUserResponse = GetAllPhotoUserResponse.fromJson(body);
    if (getAllPhotoUserResponse.status == true) {
      Global.listMyPhotos = getAllPhotoUserResponse.listPhotosUser!;
      update();
    }
    return getAllPhotoUserResponse;
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
      data = listMyPostResponse.data!;
      update();
    }
    return listMyPostResponse;
  }

  /// call api list my pending
  Future<ListMyPendingResponse> getListMyPending() async {
    ListMyPendingResponse listMyPendingResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/friends/pending"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list my pending $error");
      rethrow;
    }
    if (body == null) return ListMyPendingResponse.buildDefault();
    //get data from api here
    listMyPendingResponse = ListMyPendingResponse.fromJson(body);
    if (listMyPendingResponse.status == true) {
      debugPrint("------------- GET LIST MY PENDING SUCCESSFULLY--------------");
      Global.dataMyPending = listMyPendingResponse.data;
      Get.to(() => const ListPendingScreen());
      update();
    }
    return listMyPendingResponse;
  }
}
