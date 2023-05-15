import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';

class StoryController extends GetxController {
  int currentStory = 0;
  List<double> percentWatched = [];

  List<Widget> myStories = [
    SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          ImageAssets.imgTet,
          fit: BoxFit.cover,
        )),
    SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(ImageAssets.imgTest, fit: BoxFit.cover)),
    SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(ImageAssets.imgTet, fit: BoxFit.cover)),
  ];
  @override
  void onInit() {
    for (int i = 0; i < myStories.length; i++) {
      percentWatched.add(0);
      update();
    }
    startWatching();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void startWatching() {
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (percentWatched[currentStory] + 0.01 < 1) {
        percentWatched[currentStory] += 0.01;
      } else {
        percentWatched[currentStory] = 1;
        timer.cancel();
        if (currentStory < myStories.length - 1) {
          currentStory++;
          startWatching();
        } else {
          Get.to(() => NavigationBarView(currentIndex: 0,));
        }
      }
      update();
    });
  }

  void onTapPrevious(TapDownDetails details, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 2) {
      if (currentStory > 0) {
        percentWatched[currentStory - 1] = 0;
        percentWatched[currentStory] = 0;

        currentStory--;
      }
    } else {
      if (currentStory < myStories.length - 1) {
        percentWatched[currentStory] = 1;
        currentStory++;
      } else {
        percentWatched[currentStory] = 1;
      }
    }
  }
}
