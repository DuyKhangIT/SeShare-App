import 'data_list_comments_post_response.dart';

class ListCommentsPostResponse {
  bool status = false;
  DataListCommentsPostResponse? data;

  ListCommentsPostResponse(this.status, this.data);

  ListCommentsPostResponse.buildDefault();

  factory ListCommentsPostResponse.fromJson(Map<String, dynamic> json) {
    return ListCommentsPostResponse(
      json['status'],
      (json['data'] != null)
          ? DataListCommentsPostResponse.fromJson(json['data'])
          : null,
    );
  }
}
