import 'data_create_post_response.dart';

class CreatePostResponse {
  bool status = false;
  DataCreatePostResponse? dataCreatePostResponse;

  CreatePostResponse(this.status, this.dataCreatePostResponse);
  CreatePostResponse.buildDefault();
  factory CreatePostResponse.fromJson(Map<String, dynamic> json) {
    return CreatePostResponse(
      json['status'],
      (json['data'] != null)
          ? DataCreatePostResponse.fromJson(json['data'])
          : null,
    );
  }
}
