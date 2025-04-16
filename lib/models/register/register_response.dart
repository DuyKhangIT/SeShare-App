import 'cofirm_register_user_response.dart';

class RegisterResponse {
  int mStatusCode = 0;
  String mMessage = "";
  // ConfirmRegisterUserResponse? confirmRegisterUserResponse;

  RegisterResponse(
    this.mStatusCode,
    this.mMessage,

    ///this.confirmRegisterUserResponse,
  );
  RegisterResponse.buildDefault();
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      json['statusCode'],
      json['message'],
      // (json['user'] != null) ? ConfirmRegisterUserResponse.fromJson(json['user']) : null,
    );
  }
}
