import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../api_http/handle_api.dart';
import '../../../../models/create_chat/create_chat_request.dart';
import '../../../../models/create_chat/create_chat_response.dart';
import '../../../../models/list_chat/data_list_chat_response.dart';
import '../../../../models/list_chat/list_chat_response.dart';
import '../../../../util/global.dart';
import '../chat_view/chat_view.dart';


class ChatListController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String inputSearch = "";
  bool isSearching = false;
  bool isLoading = false;
  bool isNewUpdate = false;
  List<DataListChatResponse> dataListChat = [];
  List<DataListChatResponse> result = [];
  @override
  void onReady() {
    getListChat();
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
    result = dataListChat
        .where((element) => Global().accentParser(element.userInfoListChatResponse!.fullName)
        .toLowerCase()
        .contains(Global().accentParser(value).toLowerCase()))
        .toList();
    isSearching = value.isNotEmpty;
    update();
  }

  // /// refresh
  Future<void> refreshData() async {
    isNewUpdate = false;
    update();
    getListChat();
  }

  /// pull to refresh
  Future<void> pullToRefreshData({bool isRefreshIndicator = true}) async {
    isNewUpdate = false;
    getListChat();
    update();
    return Future.delayed(const Duration(seconds: 1));
  }

  /// call api list chat
  Future<ListChatResponse> getListChat() async {
    isLoading = true;
    update();
    ListChatResponse listChatResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/chat/get-list-chat"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list chat $error");
      rethrow;
    }
    if (body == null) return ListChatResponse.buildDefault();
    //get data from api here
    listChatResponse = ListChatResponse.fromJson(body);
    if (listChatResponse.status == true) {
      debugPrint("------------- GET LIST CHAT SUCCESSFULLY--------------");
      dataListChat = listChatResponse.data!;
      result = dataListChat;
      await Future.delayed(const Duration(seconds: 2), () {});
      isLoading = false;
      update();
    }
    return listChatResponse;
  }

  /// call api create chat
  Future<CreateChatResponse> createChat(CreateChatRequest createChatRequest) async {
    CreateChatResponse createChatResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/chat"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(createChatRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to create chat $error");
      rethrow;
    }
    if (body == null) return CreateChatResponse.buildDefault();
    //get data from api here
    createChatResponse = CreateChatResponse.fromJson(body);
    if (createChatResponse.roomId.isNotEmpty) {
      debugPrint("------------- CREATE CHAT SUCCESSFULLY--------------");
      Global.roomId = createChatResponse.roomId;
      debugPrint("RoomID: ${Global.roomId}");
      Get.to(() => const ChatView());
      update();
    }
    return createChatResponse;
  }
}
