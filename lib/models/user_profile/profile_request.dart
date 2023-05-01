class ProfileRequest {
  String mPhone;

  ProfileRequest(this.mPhone);

  Map<String, dynamic> toBodyRequest() => {
        'phone': mPhone,
      };
}
