class RegisterRequest {
  String mEmail;
  String mFullName;
  String mPassword;
  String mBirthDay;
  String? mAvatar;

  RegisterRequest(
    this.mEmail,
    this.mFullName,
    this.mPassword,
    this.mBirthDay,
    this.mAvatar,
  );

  Map<String, dynamic> toBodyRequest() => {
        'email': mEmail,
        'fullName': mFullName,
        'password': mPassword,
        'dob': mBirthDay,
        'avatar': mAvatar,
      };
}
