import '../../login/user_response.dart';

class ConfirmRegisterResponse {
  bool mStatus = false;
  UserResponse? mUserResponse;

  ConfirmRegisterResponse(
      this.mStatus,
      this.mUserResponse,
      );
  ConfirmRegisterResponse.buildDefault();
  factory ConfirmRegisterResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmRegisterResponse(
      json['status'],
      (json['user'] != null) ? UserResponse.fromJson(json['user']) : null,
    );
  }
}
