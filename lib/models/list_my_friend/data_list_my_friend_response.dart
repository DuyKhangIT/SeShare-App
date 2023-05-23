import 'package:instagram_app/models/list_my_friend/recipient_object_response.dart';

class DataListMyFriendResponse {
  String id = "";
  RecipientObjectResponse? recipientObjectResponse;

  DataListMyFriendResponse(this.id, this.recipientObjectResponse);
  DataListMyFriendResponse.buildDefault();
  factory DataListMyFriendResponse.fromJson(Map<String, dynamic> json) {
    return DataListMyFriendResponse(
      json['_id'],
      (json['recipient_id'] != null)
          ? RecipientObjectResponse.fromJson(json['recipient_id'])
          : null,
    );
  }
}
