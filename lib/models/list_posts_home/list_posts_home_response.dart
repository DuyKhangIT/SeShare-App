import 'data_posts_response.dart';

class ListPostsHomeResponse {
  bool status = false;
  List<DataPostsResponse>? data;

  ListPostsHomeResponse(this.status, this.data);

  ListPostsHomeResponse.buildDefault();

  factory ListPostsHomeResponse.fromJson(Map<String, dynamic> json) {
    List<DataPostsResponse> listDataPosts = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataPosts.add(
            DataPostsResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListPostsHomeResponse(
      json['status'],
      listDataPosts,
    );
  }
}
