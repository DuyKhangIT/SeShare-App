import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/qr_code_screen/qr_code_controller.dart';

class QRCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QRCodeController());
  }
}
