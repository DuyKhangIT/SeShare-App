import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';


class QRCodeController extends GetxController {
  ScreenshotController  screenShotController = ScreenshotController();
  Uint8List? imageFile;
  String qrFilePath = "";
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
