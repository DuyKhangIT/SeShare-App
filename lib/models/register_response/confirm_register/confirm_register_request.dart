class ConfirmRegisterRequest {
  String mPhone;
  String mPassword;
  String mFullName;
  String mBirthDay;
  String? mAvatar;

  ConfirmRegisterRequest(this.mPhone, this.mPassword,this.mFullName,this.mBirthDay,this.mAvatar);

  Map<String, dynamic> toBodyRequest() => {
    'phone': mPhone,
    'password': mPassword,
    'fullName': mFullName,
    'age': mBirthDay,
    'avatar': mAvatar,
  };
}
