import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/stories_archive/stories_archive_controller.dart';

class StoriesArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesArchiveController());
  }
}
