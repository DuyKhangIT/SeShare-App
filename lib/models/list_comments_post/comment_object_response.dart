import 'package:instagram_app/models/list_comments_post/user_infor_comment_response.dart';

class CommentObjectResponse {
  UserInfoCommentResponse? userInfoCommentResponse;
  String comment = "";
  String commentTime = "";

  CommentObjectResponse(this.userInfoCommentResponse, this.comment,this.commentTime);
  CommentObjectResponse.buildDefault();
  factory CommentObjectResponse.fromJson(Map<String, dynamic> json) {
    return CommentObjectResponse(
        (json['user'] != null)
            ? UserInfoCommentResponse.fromJson(json['user'])
            : null,
        json['comment'],
        json['comment_time']
    );
  }
}
