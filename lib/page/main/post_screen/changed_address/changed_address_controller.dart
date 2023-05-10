import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../util/global.dart';
import '../../../../util/module.dart';

class ChangedAddressController extends GetxController {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markersConsumer = {};
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    super.onClose();
  }

   CameraPosition kLake = CameraPosition(
      target: Global.latLng!,
      zoom: 15);

  Future<void> goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  void onMapCreate(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  void changeAddress() async {
    LatLng centerPosition = await getCenter();
    await placemarkFromCoordinates(
        centerPosition.latitude, centerPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
     //String address = '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}.';
     String address = getAddressFromPlaceCheckIn(place);
      // Lưu dữ liệu address vào state để sử dụng khi back về trang trước đó
      Global.checkIn = address;
      update();
      Get.back(result: address);
      debugPrint(
          "centerPosition ${centerPosition.latitude}, ${centerPosition.longitude}");
    }).catchError((e) {
      debugPrint(e.toString());
     // view.showGenericPopup();
    });

  }

  Future<LatLng> getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );
    return  Global.latLng = centerLatLng;
  }
}