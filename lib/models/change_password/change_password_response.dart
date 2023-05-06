import 'change_password_user_response.dart';

class ChangePasswordResponse {
  bool status = false;
  ChangePasswordUserResponse? changePasswordUserResponse;

  ChangePasswordResponse(
    this.status,
    this.changePasswordUserResponse,
  );
  ChangePasswordResponse.buildDefault();
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      json['status'],
      (json['user'] != null)
          ? ChangePasswordUserResponse.fromJson(json['user'])
          : null,
    );
  }
}
