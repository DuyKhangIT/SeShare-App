class LoginRequest {
  String mEmail;
  String mPassword;

  LoginRequest(this.mEmail, this.mPassword);

  Map<String, dynamic> toBodyRequest() => {
    'email': mEmail,
    'password': mPassword,
  };
}
