import 'data_my_post_response.dart';

class ListMyPostResponse {
  bool status = false;
  List<DataMyPostResponse>? data;

  ListMyPostResponse(this.status, this.data);

  ListMyPostResponse.buildDefault();

  factory ListMyPostResponse.fromJson(Map<String, dynamic> json) {
    List<DataMyPostResponse> listDataPosts = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataPosts.add(
            DataMyPostResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListMyPostResponse(
      json['status'],
      listDataPosts,
    );
  }
}
