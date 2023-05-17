import 'data_list_favorite_stories_another_user_response.dart';

class ListFavoriteStoriesAnotherUserResponse {
  bool status = false;
  DataListFavoriteStoriesAnotherUserResponse? data;

  ListFavoriteStoriesAnotherUserResponse(this.status, this.data);

  ListFavoriteStoriesAnotherUserResponse.buildDefault();

  factory ListFavoriteStoriesAnotherUserResponse.fromJson(Map<String, dynamic> json) {
    return ListFavoriteStoriesAnotherUserResponse(
      json['status'],
      (json['data'] != null)
          ? DataListFavoriteStoriesAnotherUserResponse.fromJson(json['data'])
          : null,
    );
  }
}
