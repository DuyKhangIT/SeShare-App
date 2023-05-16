import 'data_story_response.dart';

class ListStoryResponse {
  bool status = false;
  List<DataStoryResponse>? data;

  ListStoryResponse(this.status, this.data);

  ListStoryResponse.buildDefault();

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) {
    List<DataStoryResponse> listDataStories = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataStories.add(
            DataStoryResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return ListStoryResponse(
      json['status'],
      listDataStories,
    );
  }
}
