class ChangePasswordRequest {
  String mOldPassword;
  String mNewPassword;

  ChangePasswordRequest(this.mOldPassword, this.mNewPassword);

  Map<String, dynamic> toBodyRequest() => {
    'oldPassword': mOldPassword,
    'newPassword': mNewPassword,
  };
}
