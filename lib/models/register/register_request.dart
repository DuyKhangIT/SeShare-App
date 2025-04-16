import 'dart:io';

class RegisterRequest {
  String mEmail;
  String mFullName;
  String mPassword;
  String? mBirthDay;
  File? mAvatar;

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
