import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  /// new avatar from register
  static String registerNewAvatar = "";

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
}
