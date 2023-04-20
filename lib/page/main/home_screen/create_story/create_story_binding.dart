import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:instagram_app/page/main/post_screen/post_controller.dart';

import 'creat_story_controller.dart';

class CreateStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateStoryController());
  }
}
