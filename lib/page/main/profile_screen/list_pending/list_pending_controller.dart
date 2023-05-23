import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/list_my_friend/list_my_friend_response.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../api_http/handle_api.dart';
import '../../../../models/list_my_friend/data_list_my_friend_response.dart';
import '../../../../util/global.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import 'list_my_friend/list_my_friend_view.dart';


class ListPendingController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String inputSearch = "";
  String userIdForLoadListAnotherProfile = "";
  bool isSearching = false;
  bool isLoading = false;
  List<DataListMyFriendResponse> data = [];
  List<DataListMyFriendResponse> result = [];
  @override
  void onReady() {
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
        .where((element) => Global().accentParser(element.recipientObjectResponse!.fullName)
        .toLowerCase()
        .contains(Global().accentParser(value).toLowerCase()))
        .toList();
    isSearching = value.isNotEmpty;
    update();
  }

  void backAndLoadDataListFriend(){
    getListMyFriend();
    Get.to(() => NavigationBarView(currentIndex: 4));
  }

  void loadDataListFriend(){
    getListMyFriend();
    Get.to(() => const ListMyFriendScreen());
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
