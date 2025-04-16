class SendOtpRequest {
  String mEmail;

  SendOtpRequest(this.mEmail);

  Map<String, dynamic> toBodyRequest() => {
        'email': mEmail,
      };
}
