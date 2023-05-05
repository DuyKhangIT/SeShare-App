import 'another_user_profile_response.dart';

class AnOtherProfileResponse {
  bool status = false;
  AnOtherUserProfileResponse? anOtherUserProfileResponse;

  AnOtherProfileResponse(
    this.status,
    this.anOtherUserProfileResponse,
  );
  AnOtherProfileResponse.buildDefault();
  factory AnOtherProfileResponse.fromJson(Map<String, dynamic> json) {
    return AnOtherProfileResponse(
      json['status'],
      (json['user'] != null)
          ? AnOtherUserProfileResponse.fromJson(json['user'])
          : null,
    );
  }
}
