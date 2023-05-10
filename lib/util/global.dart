import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/another_user_profile/another_profile_response.dart';
import '../models/another_user_profile/another_user_profile_response.dart';
import '../models/list_comments_post/comment_object_response.dart';
import '../models/list_comments_post/data_list_comments_post_response.dart';
import '../models/list_posts_home/data_posts_response.dart';
import '../models/list_posts_home/user_infor_response.dart';
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
  /// user for item list post
  static UserInfoResponse? userInfoResponseFromListPost;
  /// user location for item list post
  static String userLocationFromListPost = "";
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

  static String convertMedia(String path,double? width,int? height) {
    debugPrint("Loaded path: " + path);
    return "http://14.225.204.248:8080/$path?width=$width&height=$height&fit=cover";
  }
}
