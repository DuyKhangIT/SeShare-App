import 'package:instagram_app/models/list_favorite_stories_another_user/story_object_favorite_stories_another_user_response.dart';

class DataListFavoriteStoriesAnotherUserResponse {
  List<StoryObjectFavoriteStoriesAnotherUserResponse>? stories;
  bool isMyStory = false;

  DataListFavoriteStoriesAnotherUserResponse(this.stories, this.isMyStory);
  DataListFavoriteStoriesAnotherUserResponse.buildDefault();
  factory DataListFavoriteStoriesAnotherUserResponse.fromJson(Map<String, dynamic> json) {
    List<StoryObjectFavoriteStoriesAnotherUserResponse>? listStories = [];
    if (json['stories'] != null) {
      List<dynamic> arrData = json['stories'];
      for (var i = 0; i < arrData.length; i++) {
        listStories.add(StoryObjectFavoriteStoriesAnotherUserResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return DataListFavoriteStoriesAnotherUserResponse(
      listStories,
      json['is_your_stories'],
    );
  }
}
