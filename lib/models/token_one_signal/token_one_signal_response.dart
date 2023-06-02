class TokenOneSignalResponse {
  bool status = false;

  TokenOneSignalResponse(
    this.status,
  );
  TokenOneSignalResponse.buildDefault();
  factory TokenOneSignalResponse.fromJson(Map<String, dynamic> json) {
    return TokenOneSignalResponse(
      json['status'],
    );
  }
}
