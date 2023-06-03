import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api_http/handle_api.dart';
import '../../../models/list_notification/data_list_notification_response.dart';
import '../../../models/list_notification/list_notification_response.dart';

class NotificationController extends GetxController {
  bool isLoading = false;
  bool isNewUpdate = false;
  List<DataListNotificationResponse> data = [];
  @override
  void onReady() {
    getListNotification();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // /// refresh
  Future<void> refreshData() async {
    isNewUpdate = false;
    update();
    getListNotification();
  }

  /// pull to refresh
  Future<void> pullToRefreshData({bool isRefreshIndicator = true}) async {
    isNewUpdate = false;
    getListNotification();
    update();
    return Future.delayed(const Duration(seconds: 1));
  }


  /// call api list post
  Future<ListNotificationResponse> getListNotification() async {
    isLoading = true;
    update();
    ListNotificationResponse listNotificationResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:8080/api/notification"),
          RequestType.post,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to get list notification $error");
      rethrow;
    }
    if (body == null) return ListNotificationResponse.buildDefault();
    //get data from api here
    listNotificationResponse = ListNotificationResponse.fromJson(body);
    if (listNotificationResponse.status == true) {
      debugPrint("------------- GET LIST NOTIFICATION SUCCESSFULLY--------------");
      data = listNotificationResponse.data;
      await Future.delayed(const Duration(seconds: 1), () {});
      isLoading = false;
      update();
    }
    return listNotificationResponse;
  }
}
