class CheckPhoneNumberRequest {
  String mPhone;

  CheckPhoneNumberRequest(this.mPhone);

  Map<String, dynamic> toBodyRequest() => {
    'phone': mPhone,
  };
}
