import 'package:instagram_app/models/list_my_stories/user_infor_my_story_response.dart';

class DataListMyStoriesResponse {
  String id = "";
  String photoPath = "";
  String privacy = "";
  UserInfoMyStoryResponse? userInfoResponse;
  bool isOver = false;
  String createTime = "";
  String createAt = "";
  bool isFavorite = false;

  DataListMyStoriesResponse(this.id, this.photoPath, this.privacy, this.userInfoResponse,
      this.isOver, this.createTime, this.createAt, this.isFavorite);
  DataListMyStoriesResponse.buildDefault();
  factory DataListMyStoriesResponse.fromJson(Map<String, dynamic> json) {
    return DataListMyStoriesResponse(
      json['_id'],
      json['photo_path'],
      json['privacy'],
      (json['user'] != null)
          ? UserInfoMyStoryResponse.fromJson(json['user'])
          : null,
      json['is_over'],
      json['upload_time'],
      json['createdAt'],
      json['is_favorite'],
    );
  }
}
