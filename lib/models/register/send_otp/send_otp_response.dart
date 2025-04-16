class SendOtpResponse {
  int mStatusCode = 0;
  String message = "";
  bool isLimited = false;
  double? timeLeft = 0.0;

  SendOtpResponse(
    this.mStatusCode,
    this.message,
    this.isLimited,
    this.timeLeft,
  );
  SendOtpResponse.buildDefault();
  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      json['statusCode'],
      json['message'],
      json['isLimited'],
      json['timeLeft'],
    );
  }
}
