class ForgotPasswordResponse {
  int statusCode = 0;
  String message = "";

  ForgotPasswordResponse(
    this.statusCode,
    this.message,
  );
  ForgotPasswordResponse.buildDefault();
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      json['statusCode'],
      json['message'],
    );
  }
}
