class UserInfoFavoriteStoriesAnotherUserResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoFavoriteStoriesAnotherUserResponse(this.id, this.fullName, this.avatar);

  UserInfoFavoriteStoriesAnotherUserResponse.buildDefault();

  factory UserInfoFavoriteStoriesAnotherUserResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoFavoriteStoriesAnotherUserResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
