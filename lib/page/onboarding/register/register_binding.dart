import 'package:get/get.dart';
import 'package:instagram_app/page/onboarding/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
