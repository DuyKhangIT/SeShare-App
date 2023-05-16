import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/delete_story/delete_story_request.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_controller.dart';
import 'package:story/story_page_view.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../util/global.dart';
import '../../../../util/module.dart';

class StoryPage extends StatefulWidget {
  int? index = 0;
  StoryPage({Key? key, this.index}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    StoryController storyController = Get.put(StoryController());
    return GetBuilder<StoryController>(
        builder: (controller) => SafeArea(
                child: Scaffold(
                    body: StoryPageView(
              gestureItemBuilder: (context, pageIndex, storyIndex) {
                return Global.listStoriesData[pageIndex].isMyStory == true
                    ? deleteStory(pageIndex, storyIndex, storyController)
                    : Container();
              },
              indicatorDuration: const Duration(seconds: 15),
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              indicatorVisitedColor: Colors.blue,
              indicatorUnvisitedColor: Colors.white,
              itemBuilder: (context, pageIndex, storyIndex) {
                return contentStory(pageIndex, storyIndex, storyController);
              },
              initialPage: widget.index!,

              /// number of stories on a page
              storyLength: (pageIndex) {
                return Global.listStoriesData[pageIndex].stories!.length;
              },

              /// number of page
              pageLength: Global.listStoriesData.length,
            ))));
  }

  Widget contentStory(pageIndex, storyIndex, StoryController storyController) {
    return Stack(
      children: [
        /// photo
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Image.network(
              Global.convertMedia(
                  Global.listStoriesData[pageIndex].stories![storyIndex]
                      .photoPath,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 1.5),
              fit: BoxFit.contain),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 40, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// avatar user
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: getNetworkImage(
                      Global.listStoriesData[pageIndex].userInfoStoryResponse!
                          .avatar,
                      width: 65,
                      height: 65),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                constraints: const BoxConstraints(
                  maxWidth: 100,
                ),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  Global.listStoriesData[pageIndex].userInfoStoryResponse!
                      .fullName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                Global
                    .listStoriesData[pageIndex].stories![storyIndex].createTime,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(width: 10),
              Image.asset(IconsAssets.icPublicMode,
                  width: 11, height: 11, color: Colors.white),
              const SizedBox(width: 120),
            ],
          ),
        ),
      ],
    );
  }

  Widget deleteStory(pageIndex, storyIndex, StoryController storyController) {
    /// delete story
    return GestureDetector(
      onTap: () {
        if (Global.isAvailableToClick()) {
          DeleteStoryRequest deleteStoryRequest = DeleteStoryRequest(
              Global.listStoriesData[pageIndex].stories![storyIndex].id);
          storyController.deleteStory(deleteStoryRequest);
        }
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 40,
          height: 25,
          margin: const EdgeInsets.only(bottom: 20, right: 20),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Image.asset(IconsAssets.icDeletePost,
              width: 11, height: 11, color: Colors.black),
        ),
      ),
    );
  }
}
