class DataListMyStoriesResponse {
  String id = "";
  String photoPath = "";
  String privacy = "";
  String userId = "";
  bool isOver = false;
  String createTime = "";
  String createAt = "";
  bool isFavorite = false;

  DataListMyStoriesResponse(this.id, this.photoPath, this.privacy, this.userId,
      this.isOver, this.createTime, this.createAt, this.isFavorite);
  DataListMyStoriesResponse.buildDefault();
  factory DataListMyStoriesResponse.fromJson(Map<String, dynamic> json) {
    return DataListMyStoriesResponse(
      json['_id'],
      json['photo_path'],
      json['privacy'],
      json['user'],
      json['is_over'],
      json['upload_time'],
      json['createdAt'],
      json['is_favorite'],
    );
  }
}
