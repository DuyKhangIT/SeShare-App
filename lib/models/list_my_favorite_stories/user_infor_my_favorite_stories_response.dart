class UserInfoMyFavoriteStoriesResponse {
  String id = "";
  String fullName = "";
  String avatar = "";

  UserInfoMyFavoriteStoriesResponse(this.id, this.fullName, this.avatar);

  UserInfoMyFavoriteStoriesResponse.buildDefault();

  factory UserInfoMyFavoriteStoriesResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoMyFavoriteStoriesResponse(
      json['_id'],
      json['full_name'],
      json['avatar_path'],
    );
  }
}
