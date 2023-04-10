import 'package:instagram_app/models/login/user_response.dart';

class AuthenticationResponse {
  bool status = false;
  UserResponse? userResponse;
  String? token = "";

  AuthenticationResponse(
    this.status,
    this.userResponse,
    this.token,
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
