import 'data_my_list_favorite_stories_response.dart';

class ListMyFavoriteStoriesResponse {
  bool status = false;
  DataListMyFavoriteStoriesResponse? data;

  ListMyFavoriteStoriesResponse(this.status, this.data);

  ListMyFavoriteStoriesResponse.buildDefault();

  factory ListMyFavoriteStoriesResponse.fromJson(Map<String, dynamic> json) {
    return ListMyFavoriteStoriesResponse(
      json['status'],
      (json['data'] != null)
          ? DataListMyFavoriteStoriesResponse.fromJson(json['data'])
          : null,
    );
  }
}
