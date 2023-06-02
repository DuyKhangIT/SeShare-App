import 'package:instagram_app/models/list_chat/user_infor_list_chat_response.dart';

class DataListChatResponse {
  String roomId = "";
  String content = "";
  UserInfoListChatResponse? userInfoListChatResponse;
  DataListChatResponse(
      this.roomId, this.content, this.userInfoListChatResponse);
  DataListChatResponse.buildDefault();
  factory DataListChatResponse.fromJson(Map<String, dynamic> json) {
    return DataListChatResponse(
      json['_id'],
      json['content'],
      (json['user'] != null)
          ? UserInfoListChatResponse.fromJson(json['user'])
          : null,
    );
  }
}
