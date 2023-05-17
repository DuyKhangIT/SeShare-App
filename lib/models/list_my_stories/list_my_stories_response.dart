import 'data_list_my_stories_response.dart';

class ListMyStoriesResponse {
  bool status = false;
  List<DataListMyStoriesResponse>? data;

  ListMyStoriesResponse(this.status, this.data);

  ListMyStoriesResponse.buildDefault();

  factory ListMyStoriesResponse.fromJson(Map<String, dynamic> json) {
    List<DataListMyStoriesResponse> listDataStories = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataStories.add(
            DataListMyStoriesResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListMyStoriesResponse(
      json['status'],
      listDataStories,
    );
  }
}