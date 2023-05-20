import 'data_search_user_response.dart';

class SearchUserResponse {
  bool status = false;
  List<DataSearchUserResponse>? data;

  SearchUserResponse(this.status, this.data);

  SearchUserResponse.buildDefault();

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) {
    List<DataSearchUserResponse> listDataStories = [];
    if (json['data'] != null) {
      List<dynamic> arrData = json['data'];
      for (var i = 0; i < arrData.length; i++) {
        listDataStories.add(
            DataSearchUserResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return SearchUserResponse(
      json['status'],
      listDataStories,
    );
  }
}