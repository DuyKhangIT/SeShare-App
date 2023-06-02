import 'data_list_chat_response.dart';

class ListChatResponse {
  bool status = false;
  List<DataListChatResponse>? data;
  ListChatResponse(this.status, this.data);
  ListChatResponse.buildDefault();
  factory ListChatResponse.fromJson(Map<String, dynamic> json) {
    List<DataListChatResponse> listChat = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listChat.add(
            DataListChatResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListChatResponse(json['status'], listChat);
  }
}
