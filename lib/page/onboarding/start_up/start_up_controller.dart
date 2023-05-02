import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../api_http/handle_api.dart';
import '../../../config/share_preferences.dart';
import '../../../util/global.dart';
import '../../navigation_bar/navigation_bar_view.dart';

class StartUpController extends GetxController{
  RxBool isNewUser = false.obs;

  @override
  void onReady() {
    getCurrentLocation();
    checkAlreadyLoggedIn();
    super.onReady();
  }



  /// check login with shared preferences
  Future<void> checkAlreadyLoggedIn() async {
    String? userToken = await ConfigSharedPreferences().getStringValue(
        SharedData.TOKEN.toString(),
        defaultValue: "");
    if (userToken.isEmpty || userToken == "") {
      isNewUser.value = true;
    } else {
      Global.mToken = userToken;
      loading();
    }
  }

  Future<void> loading() async {
    await Future.delayed(const Duration(seconds: 3));
    isNewUser.value = false;
    Get.to(() =>  const NavigationBarView());
    update();
  }

  Future<void> getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Xử lý trường hợp người dùng từ chối cấp quyền truy cập vị trí
        Get.defaultDialog(
            backgroundColor: Colors.green,
            titleStyle: const TextStyle(color: Colors.white),
            middleTextStyle: const TextStyle(color: Colors.white),
            textConfirm: "Confirm",
            textCancel: "Cancel",
            onConfirm: (){
              Navigator.pop(Get.context!);
            },
            onCancel: (){},
            cancelTextColor: Colors.white,
            confirmTextColor: Colors.white,
            buttonColor: Colors.red,
            barrierDismissible: false,
            radius: 50,
            content: const Text("Vui lòng cấp quyền truy cập vị trí để sử dụng tính năng này.")
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Xử lý trường hợp người dùng không bao giờ muốn cấp quyền truy cập vị trí
      Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          textConfirm: "Confirm",
          textCancel: "Cancel",
          onConfirm: (){
            Navigator.pop(Get.context!);
          },
          onCancel: (){
            Navigator.pop(Get.context!);
          },
          cancelTextColor: Colors.white,
          confirmTextColor: Colors.white,
          buttonColor: Colors.red,
          barrierDismissible: false,
          radius: 50,
          content: Text("Bạn đã từ chối cấp quyền truy cập vị trí. Vui lòng cấp quyền trong phần cài đặt của thiết bị.")
      );
      update();
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng latLng = LatLng(position.latitude, position.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String fullAddress = '${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}.';
    //String fullAddress = '${placemark.street}, ${placemark.subAdministrativeArea},${placemark.administrativeArea},${placemark.country}.';
    Global.currentLocation = fullAddress;
    Global.latLng = latLng;
  }


  @override
  void onClose() {
    super.onClose();
  }


}