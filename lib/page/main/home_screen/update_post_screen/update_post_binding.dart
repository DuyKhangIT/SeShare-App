import 'package:get/get.dart';
import 'package:instagram_app/page/main/home_screen/update_post_screen/update_post_controller.dart';


class UpdatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdatePostController());
  }
}
