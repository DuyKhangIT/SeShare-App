import 'forgot_password_user_response.dart';

class ForgotPasswordResponse {
  bool status = false;
  ForgotPasswordUserResponse? forgotPasswordUserResponse;

  ForgotPasswordResponse(
    this.status,
    this.forgotPasswordUserResponse,
  );
  ForgotPasswordResponse.buildDefault();
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      json['status'],
      (json['user'] != null)
          ? ForgotPasswordUserResponse.fromJson(json['user'])
          : null,
    );
  }
}
