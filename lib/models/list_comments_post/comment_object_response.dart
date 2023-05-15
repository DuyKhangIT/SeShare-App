import 'package:instagram_app/models/list_comments_post/user_infor_comment_response.dart';

class CommentObjectResponse {
  String commentId = "";
  UserInfoCommentResponse? userInfoCommentResponse;
  String comment = "";
  String commentTime = "";
  bool isCommented = false;

  CommentObjectResponse(this.commentId,this.userInfoCommentResponse, this.comment,this.commentTime,this.isCommented);
  CommentObjectResponse.buildDefault();
  factory CommentObjectResponse.fromJson(Map<String, dynamic> json) {
    return CommentObjectResponse(
        json['_id'],
        (json['user'] != null)
            ? UserInfoCommentResponse.fromJson(json['user'])
            : null,
        json['comment'],
        json['comment_time'],
        json['is_commented'],
    );
  }
}
