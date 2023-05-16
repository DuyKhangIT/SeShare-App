import 'package:instagram_app/models/list_story/story_object_response.dart';
import 'package:instagram_app/models/list_story/user_infor_story_response.dart';

class DataStoryResponse {
  String id = "";
  List<StoryObjectResponse>? stories;
  UserInfoStoryResponse? userInfoStoryResponse;
  bool isMyStory = false;

  DataStoryResponse(this.id, this.stories, this.userInfoStoryResponse,this.isMyStory);
  DataStoryResponse.buildDefault();
  factory DataStoryResponse.fromJson(Map<String, dynamic> json) {
    List<StoryObjectResponse>? listStories = [];
    if (json['story'] != null) {
      List<dynamic> arrData = json['story'];
      for (var i = 0; i < arrData.length; i++) {
        listStories.add(
            StoryObjectResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return DataStoryResponse(
        json['_id'],
        listStories,
        (json['user'] != null)
            ? UserInfoStoryResponse.fromJson(json['user'])
            : null,
        json['is_your_stories'],
    );

  }
}
