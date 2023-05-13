import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/post_screen/changed_address/changed_address_controller.dart';

import '../../../../util/global.dart';

class ChangedAddressView extends StatefulWidget {
  const ChangedAddressView({Key? key}) : super(key: key);

  @override
  State<ChangedAddressView> createState() => _ChangedAddressViewState();
}

class _ChangedAddressViewState extends State<ChangedAddressView> {
  ChangedAddressController changedAddressController =
      Get.put(ChangedAddressController());
  GoogleMapController? mapController;



  @override
  Widget build(BuildContext context) {
    Set<Marker> allMarkers = {};
    allMarkers.addAll(changedAddressController.markersConsumer);
    return GetBuilder<ChangedAddressController>(
        builder: (controller) => Scaffold(
              body: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: changedAddressController.onMapCreate,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    markers: allMarkers,
                    initialCameraPosition: changedAddressController.kLake,
                    minMaxZoomPreference: const MinMaxZoomPreference(5, 26),
                  ),
                  myLocationButton(),
                  addressBox(),
                  bottomButtons(),
                  centerMapIcon()
                ],
              ),
            ));
  }

  Widget centerMapIcon() {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Image.asset(
              IconsAssets.icLocationPost,
              width: 30,
              height: 50,
              fit: BoxFit.cover,
            )));
  }

  Widget myLocationButton() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 35, 140),
            child: GestureDetector(
                onTap: () {
                  changedAddressController.goToTheLake();
                },
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(children: <Widget>[
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 5),
                                  blurRadius: 5)
                            ],
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          )),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(IconsAssets.icGPS))),
                    ])))));
  }

  Widget addressBox() {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(38, 60, 38, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(children: [
                Image.asset(IconsAssets.icMapMarker, width: 22, height: 22),
                const SizedBox(width: 7),
                Flexible(
                    child: Text(
                      Global.checkIn.isEmpty ? Global.currentLocation : Global.checkIn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ))
              ]),
            )));
  }

  Widget bottomButtons() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Row(children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.6,
                color: Colors.transparent,
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: (4),
                          shadowColor: Colors.black,
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Hủy".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ))),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.6,
                color: Colors.transparent,
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 4,
                          shadowColor: Colors.black,
                          side: const BorderSide(color: Colors.white, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          changedAddressController.changeAddress();
                        },
                        child: Text(
                          "Chọn địa chỉ".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ))),
              )
            ])));
  }
}
