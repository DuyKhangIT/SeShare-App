import 'comment_object_response.dart';

class DataListCommentsPostResponse {
  String id = "";
  String postId = "";
  List<CommentObjectResponse>? comments;
  DataListCommentsPostResponse(this.id, this.postId, this.comments);
  DataListCommentsPostResponse.buildDefault();
  factory DataListCommentsPostResponse.fromJson(Map<String, dynamic> json) {
    List<CommentObjectResponse> listCmt = [];
    if (json['comments'] != null) {
      List<dynamic> arrData = json['comments'];
      for (var i = 0; i < arrData.length; i++) {
        listCmt.add(
            CommentObjectResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return DataListCommentsPostResponse(
      json['_id'],
      json['post_id'],
      listCmt,
    );
  }
}
