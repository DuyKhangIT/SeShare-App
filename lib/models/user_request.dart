class UserRequest {
  String? mPhone;
  String? mPassword;

  UserRequest(this.mPhone, this.mPassword);

  Map<String, dynamic> toBodyRequest() => {
    'phone': mPhone,
    'password': mPassword,
  };
}
