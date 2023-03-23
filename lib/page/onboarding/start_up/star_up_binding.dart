import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:instagram_app/page/onboarding/start_up/start_up_controller.dart';

class StartUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartUpController());
  }
}