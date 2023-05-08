import 'package:instagram_app/models/list_comments_post/user_infor_comment_response.dart';

class CommentObjectResponse {
  UserInfoCommentResponse? userInfoCommentResponse;
  String comment = "";

  CommentObjectResponse(this.userInfoCommentResponse, this.comment);
  CommentObjectResponse.buildDefault();
  factory CommentObjectResponse.fromJson(Map<String, dynamic> json) {
    return CommentObjectResponse(
        (json['user'] != null)
            ? UserInfoCommentResponse.fromJson(json['user'])
            : null,
        json['comment']);
  }
}
