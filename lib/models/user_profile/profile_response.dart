import 'package:instagram_app/models/user_profile/user_profile_response.dart';

class ProfileResponse {
  bool status = false;
  UserProfileResponse? userProfileResponse;

  ProfileResponse(
    this.status,
    this.userProfileResponse,
  );
  ProfileResponse.buildDefault();
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      json['status'],
      (json['user'] != null)
          ? UserProfileResponse.fromJson(json['user'])
          : null,
    );
  }
}
