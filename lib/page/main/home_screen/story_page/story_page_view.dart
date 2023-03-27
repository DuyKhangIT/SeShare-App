import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_controller.dart';
import 'package:instagram_app/widget/percent_indicator.dart';

import '../../../../widget/my_story_bar.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    StoryController storyController = Get.put(StoryController());
    return GetBuilder<StoryController>(
        builder: (controller) => SafeArea(
                child: GestureDetector(
              onTapDown: (details) {
                storyController.onTapPrevious(details, context);
              },
              child: Scaffold(
                  body: Stack(
                children: [
                  storyController.myStories[storyController.currentStory],
                  MyStoryBar(percentWatched: storyController.percentWatched)
                ],
              )),
            )));
  }
}
