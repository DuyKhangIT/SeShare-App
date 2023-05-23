import 'data_list_my_friend_response.dart';

class ListMyFriendResponse {
  bool status = false;
  List<DataListMyFriendResponse> data = [];

  ListMyFriendResponse(this.status, this.data);

  ListMyFriendResponse.buildDefault();

  factory ListMyFriendResponse.fromJson(Map<String, dynamic> json) {
    List<DataListMyFriendResponse>? listMyFriend = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listMyFriend.add(DataListMyFriendResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return ListMyFriendResponse(json['status'], listMyFriend);
  }
}
