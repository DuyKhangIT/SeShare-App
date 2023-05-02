class ConfirmRegisterRequest {
  String mPhone;
  String mPassword;
  String mFullName;
  String? mAvatar;

  ConfirmRegisterRequest(this.mPhone, this.mPassword,this.mFullName,this.mAvatar);

  Map<String, dynamic> toBodyRequest() => {
    'phone': mPhone,
    'password': mPassword,
    'fullName': mFullName,
    'avatar': mAvatar,
  };
}
