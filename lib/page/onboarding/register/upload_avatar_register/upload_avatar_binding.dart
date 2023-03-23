import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:instagram_app/page/onboarding/register/upload_avatar_register/upload_avatar_controller.dart';

class UploadAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadAvatarController());
  }
}
