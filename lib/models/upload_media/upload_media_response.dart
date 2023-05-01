class UploadMediaResponse {
  bool status = false;
  String? data = "";

  UploadMediaResponse(this.status, this.data);
  UploadMediaResponse.buildDefault();
  factory UploadMediaResponse.fromJson(Map<String, dynamic> json) {
    return UploadMediaResponse(
      json['status'],
      json['data'],
    );
  }
}
