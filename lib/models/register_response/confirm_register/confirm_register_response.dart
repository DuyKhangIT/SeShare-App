import 'cofirm_register_user_response.dart';

class ConfirmRegisterResponse {
  bool mStatus = false;
  ConfirmRegisterUserResponse? confirmRegisterUserResponse;

  ConfirmRegisterResponse(
      this.mStatus,
      this.confirmRegisterUserResponse,
      );
  ConfirmRegisterResponse.buildDefault();
  factory ConfirmRegisterResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmRegisterResponse(
      json['status'],
      (json['user'] != null) ? ConfirmRegisterUserResponse.fromJson(json['user']) : null,
    );
  }
}
