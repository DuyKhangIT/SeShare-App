import 'package:instagram_app/models/list_notification/who_user_response.dart';

class DataListNotificationResponse {
  String id = "";
  String content = "";
  WhoUserObjectResponse? whoUser;
  String uploadTime = "";

  DataListNotificationResponse(this.id, this.content, this.whoUser,this.uploadTime);
  DataListNotificationResponse.buildDefault();
  factory DataListNotificationResponse.fromJson(Map<String, dynamic> json) {
    return DataListNotificationResponse(
      json['_id'],
      json['content'],
      (json['who_user'] != null)
          ? WhoUserObjectResponse.fromJson(json['who_user'])
          : null,
      json['upload_time'],
    );
  }
}
