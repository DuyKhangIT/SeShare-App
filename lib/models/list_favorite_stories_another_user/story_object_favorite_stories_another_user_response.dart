import 'package:instagram_app/models/list_favorite_stories_another_user/user_infor_favorite_stories_another_user_response.dart';

class StoryObjectFavoriteStoriesAnotherUserResponse {
  String id = "";
  String photoPath = "";
  String privacy = "";
  UserInfoFavoriteStoriesAnotherUserResponse? userInfoResponse;
  bool isOver = false;
  String createTime = "";
  bool isFavorite = false;

  StoryObjectFavoriteStoriesAnotherUserResponse(this.id, this.photoPath, this.privacy, this.userInfoResponse,
      this.isOver, this.createTime,this.isFavorite);

  StoryObjectFavoriteStoriesAnotherUserResponse.buildDefault();

  factory StoryObjectFavoriteStoriesAnotherUserResponse.fromJson(Map<String, dynamic> json) {
    return StoryObjectFavoriteStoriesAnotherUserResponse(
      json['_id'],
      json['photo_path'],
      json['privacy'],
      (json['user'] != null)
          ? UserInfoFavoriteStoriesAnotherUserResponse.fromJson(json['user'])
          : null,
      json['is_over'],
      json['upload_time'],
      json['is_favorite'],
    );
  }
}
