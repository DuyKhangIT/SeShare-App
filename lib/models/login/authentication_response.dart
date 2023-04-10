import 'package:instagram_app/models/login/user_response.dart';

class AuthenticationResponse {
  bool mStatus = false;
  UserResponse? mUserResponse;
  String? mToken = "";

  AuthenticationResponse(
    this.mStatus,
    this.mUserResponse,
    this.mToken,
  );
  AuthenticationResponse.buildDefault();
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
      json['status'],
      (json['user'] != null) ? UserResponse.fromJson(json['user']) : null,
      json['token'],
    );
  }
}
