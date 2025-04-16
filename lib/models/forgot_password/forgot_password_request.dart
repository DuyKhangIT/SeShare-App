class ForgotPasswordRequest {
  String mEmail;
  String mNewPassword;

  ForgotPasswordRequest(this.mEmail, this.mNewPassword);

  Map<String, dynamic> toBodyRequest() => {
    'email': mEmail,
    'newPassword': mNewPassword,
  };
}
