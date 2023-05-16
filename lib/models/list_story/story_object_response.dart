class StoryObjectResponse {
  String id = "";
  String photoPath = "";
  double xPositionText = 0.0;
  double yPositionText = 0.0;
  String colorText = "";
  String text = "";
  String privacy = "";
  String userId = "";
  bool isOver = false;
  String createTime = "";
  double scaleText = 0;

  StoryObjectResponse(
      this.id,
      this.photoPath,
      this.xPositionText,
      this.yPositionText,
      this.colorText,
      this.text,
      this.privacy,
      this.userId,
      this.isOver,
      this.createTime,
      this.scaleText);

  StoryObjectResponse.buildDefault();

  factory StoryObjectResponse.fromJson(Map<String, dynamic> json) {
    return StoryObjectResponse(
      json['_id'],
      json['photo_path'],
      json['x_text'],
      json['y_text'],
      json['color_text'],
      json['text'],
      json['privacy'],
      json['user'],
      json['is_over'],
      json['upload_time'],
      json['scale_text'],
    );
  }
}
