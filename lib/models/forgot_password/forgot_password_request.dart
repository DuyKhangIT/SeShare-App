class ForgotPasswordRequest {
  String mPhone;
  String mNewPassword;

  ForgotPasswordRequest(this.mPhone, this.mNewPassword);

  Map<String, dynamic> toBodyRequest() => {
    'phone': mPhone,
    'newPassword': mNewPassword,
  };
}
