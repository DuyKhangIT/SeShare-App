import 'data_another_post_response.dart';

class ListAnotherPostResponse {
  bool status = false;
  List<DataAnotherPostResponse>? data;

  ListAnotherPostResponse(this.status, this.data);

  ListAnotherPostResponse.buildDefault();

  factory ListAnotherPostResponse.fromJson(Map<String, dynamic> json) {
    List<DataAnotherPostResponse> listDataPosts = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataPosts.add(
            DataAnotherPostResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListAnotherPostResponse(
      json['status'],
      listDataPosts,
    );
  }
}
