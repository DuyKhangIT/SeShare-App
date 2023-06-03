import 'data_list_notification_response.dart';

class ListNotificationResponse {
  bool status = false;
  List<DataListNotificationResponse> data = [];

  ListNotificationResponse(this.status, this.data);

  ListNotificationResponse.buildDefault();

  factory ListNotificationResponse.fromJson(Map<String, dynamic> json) {
    List<DataListNotificationResponse>? listNotification = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listNotification.add(DataListNotificationResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return ListNotificationResponse(json['status'], listNotification);
  }
}
