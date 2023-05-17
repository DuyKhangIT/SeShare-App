import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/posts_archive/post_archive_controller.dart';

class PostArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostArchiveController());
  }
}
