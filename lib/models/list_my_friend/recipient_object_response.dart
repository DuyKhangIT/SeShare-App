class RecipientObjectResponse {
  String id = "";
  String fullName = "";
  String avatar = "";
  String bio = "";

  RecipientObjectResponse(this.id, this.fullName, this.avatar,this.bio);

  RecipientObjectResponse.buildDefault();

  factory RecipientObjectResponse.fromJson(Map<String, dynamic> json) {
    return RecipientObjectResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
      json['bio'],
    );
  }
}
