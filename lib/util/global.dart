import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instagram_app/models/list_my_favorite_stories/story_object_my_favorite_stories_response.dart';
import 'package:instagram_app/models/list_story/data_story_response.dart';

import '../models/another_user_profile/another_user_profile_response.dart';
import '../models/list_comments_post/data_list_comments_post_response.dart';
import '../models/list_favorite_stories_another_user/story_object_favorite_stories_another_user_response.dart';
import '../models/list_my_stories/data_list_my_stories_response.dart';
import '../models/list_posts_home/data_posts_response.dart';
import '../models/user_profile/user_profile_response.dart';

class Global {
  static String verifyFireBase = "";

  static const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
  static const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
  static const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
  static const blueColor = Color.fromRGBO(0, 149, 246, 1);
  static const primaryColor = Colors.white;
  static const secondaryColor = Colors.grey;
  static String checkIn = "";
  static LatLng? latLng;
  static String currentLocation = "";
  static String mToken = "";

  /// new phone number from register
  static String phoneNumber = "";

  /// new password from register
  static String registerNewPassword = "";

  /// new full name from register
  static String registerNewFullName = "";

  /// new birthday from register
  static String registerNewBirthday = "";

  /// new avatar from register
  static String registerNewAvatar = "";
  static String userId = "";
  static UserProfileResponse? userProfileResponse;
  static List<String> listPhotoAnOtherUser = [];
  static AnOtherUserProfileResponse? anOtherUserProfileResponse;

  /// data list post
  static List<DataPostsResponse> listPostInfo = [];
  static List<DataStoryResponse> listStoriesData = [];

  /// list my stories
  static List<DataListMyStoriesResponse> listMyStories = [];

  /// list favorite stories another user
  static List<StoryObjectFavoriteStoriesAnotherUserResponse> listFavoriteStoriesAnotherUser = [];

  /// list my favorite stories
  static List<StoryObjectMyFavoriteStoriesResponse> listMyFavoriteStories = [];

  /// info post home
  static DataPostsResponse? infoMyPost;

  /// new phone number from forgot password
  static String phoneNumberForgotPassword = "";

  /// data list cmt response
  static DataListCommentsPostResponse? dataListCmt;

  /// id post for cmt post
  static String idPost = "";

  /// block auto click or many time click
  static int mTimeClick = 0;

  static bool isAvailableToClick() {
    debugPrint("clicked ${DateTime.now().millisecondsSinceEpoch - mTimeClick}");
    if (DateTime.now().millisecondsSinceEpoch - mTimeClick > 1000) {
      mTimeClick = DateTime.now().millisecondsSinceEpoch;
      return true;
    }
    return false;
  }

  static String convertMedia(String path, double? width, double? height) {
    debugPrint("Loaded path: " + path);
    return "http://14.225.204.248:8080/$path?width=$width&height=$height&fit=cover";
  }

  /// kí tự tiếng việt
  String accentParser(String text) {
    const String _vietnamese = 'aAeEoOuUiIdDyY';
    final _vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];

    String result = text;
    for (var i = 0; i < _vietnamese.length; ++i) {
      result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return result;
  }
}
