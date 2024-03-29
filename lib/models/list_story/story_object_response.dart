class StoryObjectResponse {
  String id = "";
  String photoPath = "";
  String privacy = "";
  String userId = "";
  bool isOver = false;
  String createTime = "";
  bool isFavorite = false;

  StoryObjectResponse(this.id, this.photoPath, this.privacy, this.userId,
      this.isOver, this.createTime,this.isFavorite);

  StoryObjectResponse.buildDefault();

  factory StoryObjectResponse.fromJson(Map<String, dynamic> json) {
    return StoryObjectResponse(
      json['_id'],
      json['photo_path'],
      json['privacy'],
      json['user'],
      json['is_over'],
      json['upload_time'],
      json['is_favorite'],
    );
  }
}
