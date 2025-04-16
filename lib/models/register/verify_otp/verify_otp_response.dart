class VerifyOtpResponse {
  int mStatusCode = 0;
  String message = "";

  VerifyOtpResponse(
    this.mStatusCode,
    this.message,
  );
  VerifyOtpResponse.buildDefault();
  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      json['statusCode'],
      json['message'],
    );
  }
}
