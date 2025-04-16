class LoginResponse {
  int statusCode = 0;

  String? token;
  String message = "";

  LoginResponse(
    this.statusCode,
    this.token,
    this.message,
  );
  LoginResponse.buildDefault();
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['statusCode'],
      json['token'],
      json['message'],
    );
  }
}
