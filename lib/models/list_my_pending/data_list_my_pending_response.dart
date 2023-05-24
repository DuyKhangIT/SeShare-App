import 'package:instagram_app/models/list_my_pending/recipient_object_my_pending_response.dart';

class DataListMyPendingResponse {
  String id = "";
  RecipientObjectMyPendingResponse? recipientObjectMyPendingResponse;

  DataListMyPendingResponse(this.id, this.recipientObjectMyPendingResponse);
  DataListMyPendingResponse.buildDefault();
  factory DataListMyPendingResponse.fromJson(Map<String, dynamic> json) {
    return DataListMyPendingResponse(
      json['_id'],
      (json['recipient_id'] != null)
          ? RecipientObjectMyPendingResponse.fromJson(json['recipient_id'])
          : null,
    );
  }
}
