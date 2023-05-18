import 'package:instagram_app/models/list_my_favorite_stories/story_object_my_favorite_stories_response.dart';

class DataListMyFavoriteStoriesResponse {
  List<StoryObjectMyFavoriteStoriesResponse>? stories;
  bool isMyStory = false;

  DataListMyFavoriteStoriesResponse(this.stories, this.isMyStory);
  DataListMyFavoriteStoriesResponse.buildDefault();
  factory DataListMyFavoriteStoriesResponse.fromJson(
      Map<String, dynamic> json) {
    List<StoryObjectMyFavoriteStoriesResponse>? listMyFavStories = [];
    if (json['stories'] != null) {
      List<dynamic> arrData = json['stories'];
      for (var i = 0; i < arrData.length; i++) {
        listMyFavStories.add(StoryObjectMyFavoriteStoriesResponse.fromJson(
            arrData[i] as Map<String, dynamic>));
      }
    }
    return DataListMyFavoriteStoriesResponse(
      listMyFavStories,
      json['is_your_stories'],
    );
  }
}
