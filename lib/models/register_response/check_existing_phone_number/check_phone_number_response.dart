class CheckPhoneNumberResponse {
  bool status = false;
  String userContent = "";

  CheckPhoneNumberResponse(this.status, this.userContent);
  CheckPhoneNumberResponse.buildDefault();
  factory CheckPhoneNumberResponse.fromJson(Map<String, dynamic> json) {
    return CheckPhoneNumberResponse(
      json['status'],
      json['user'],
    );
  }
}
