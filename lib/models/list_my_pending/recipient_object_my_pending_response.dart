class RecipientObjectMyPendingResponse {
  String id = "";
  String fullName = "";
  String avatar = "";
  String bio = "";

  RecipientObjectMyPendingResponse(this.id, this.fullName, this.avatar,this.bio);

  RecipientObjectMyPendingResponse.buildDefault();

  factory RecipientObjectMyPendingResponse.fromJson(Map<String, dynamic> json) {
    return RecipientObjectMyPendingResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
      json['bio'],
    );
  }
}
