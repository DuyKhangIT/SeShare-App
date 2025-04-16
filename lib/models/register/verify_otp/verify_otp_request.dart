class VerifyOtpRequest {
  String mEmail;
  String mOtp;

  VerifyOtpRequest(this.mEmail, this.mOtp);

  Map<String, dynamic> toBodyRequest() => {
        'email': mEmail,
        'otp': mOtp,
      };
}
