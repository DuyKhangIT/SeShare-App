import 'dart:async';
import 'package:get/get.dart';

class HandleOtp extends GetxController {
  @override
  void onInit() {
    super.onInit();
    firstLoad();
  }

  void firstLoad() {
    startTimer();
  }

  /// Đếm ngược
  var start = 59.obs;

  void startTimer() {
    start.value = 59;
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }
}
