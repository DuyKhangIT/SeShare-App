import 'package:instagram_app/models/list_my_favorite_stories/user_infor_my_favorite_stories_response.dart';

class StoryObjectMyFavoriteStoriesResponse {
  String id = "";
  String photoPath = "";
  String privacy = "";
  UserInfoMyFavoriteStoriesResponse? userInfoResponse;
  bool isOver = false;
  String createTime = "";
  bool isFavorite = false;

  StoryObjectMyFavoriteStoriesResponse(this.id, this.photoPath, this.privacy,
      this.userInfoResponse, this.isOver, this.createTime, this.isFavorite);

  StoryObjectMyFavoriteStoriesResponse.buildDefault();

  factory StoryObjectMyFavoriteStoriesResponse.fromJson(
      Map<String, dynamic> json) {
    return StoryObjectMyFavoriteStoriesResponse(
      json['_id'],
      json['photo_path'],
      json['privacy'],
      (json['user'] != null)
          ? UserInfoMyFavoriteStoriesResponse.fromJson(json['user'])
          : null,
      json['is_over'],
      json['upload_time'],
      json['is_favorite'],
    );
  }
}
