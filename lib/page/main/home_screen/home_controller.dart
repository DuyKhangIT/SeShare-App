import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_controller.dart';

import '../../../models/story_data.dart';

class HomeController extends GetxController {

  final List<Story> stories = [
    Story(
      url:
      'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      duration: const Duration(seconds: 10),
      userName: 'Duy Khang',
    ),
    Story(
      url:
      'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      duration: const Duration(seconds: 10),
      userName: 'An Vũ',
    ),
    Story(
      url:
      'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      duration: const Duration(seconds: 10),
      userName: 'Khang Nguyễn',
    ),

  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
