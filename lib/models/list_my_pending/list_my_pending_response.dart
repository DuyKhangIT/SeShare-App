import 'data_list_my_pending_response.dart';

class ListMyPendingResponse {
  bool status = false;
  List<DataListMyPendingResponse> data = [];

  ListMyPendingResponse(this.status, this.data);

  ListMyPendingResponse.buildDefault();

  factory ListMyPendingResponse.fromJson(Map<String, dynamic> json) {
    List<DataListMyPendingResponse>? listMyPending = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listMyPending.add(DataListMyPendingResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return ListMyPendingResponse(json['status'], listMyPending);
  }
}
