import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                child: GestureDetector(
              onTapDown: (details) {
                storyController.onTapPrevious(details, context);
              },
              child: Scaffold(
                  body: StoryPageView(
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                indicatorVisitedColor: Colors.blue,
                indicatorUnvisitedColor: Colors.black.withOpacity(0.4),
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
              )),
            )));
  }

  Widget contentStory(pageIndex, storyIndex, StoryController storyController) {
    return Stack(
      children: [
        /// photo
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: getNetworkImage(
              Global.listStoriesData[pageIndex].stories![storyIndex].photoPath,
              width: MediaQuery.of(context).size.width / 1.5,
              height: 400),
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
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                Global
                    .listStoriesData[pageIndex].stories![storyIndex].createTime,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(width: 10),
              Image.asset(IconsAssets.icPublicMode,
                  width: 11, height: 11, color: Colors.black)
            ],
          ),
        ),
        Positioned(
          left: Global.listStoriesData[pageIndex].stories![storyIndex]
                  .xPositionText +
              100.0,
          //xPosition,
          top: Global
              .listStoriesData[pageIndex].stories![storyIndex].yPositionText,
          //yPosition,
          child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 200),
              child: Text(
                Global.listStoriesData[pageIndex].stories![storyIndex].text,
                style: TextStyle(
                    color: Color(int.parse(Global.listStoriesData[pageIndex]
                        .stories![storyIndex].colorText)),
                    fontSize: 14 *
                        Global.listStoriesData[pageIndex].stories![storyIndex]
                            .scaleText,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
