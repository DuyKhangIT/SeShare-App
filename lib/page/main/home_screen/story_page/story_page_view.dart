import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_controller.dart';
import 'package:story/story_page_view.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../assets/images_assets.dart';

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
                  body: StoryPageView(
                indicatorPadding:
                   const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemBuilder: (context, pageIndex, storyIndex) {
                  return contentStory(pageIndex, storyIndex, storyController);
                },

                /// số tin trong 1 trang
                storyLength: (pageIndex) {
                  return 3;
                },

                /// số trang
                pageLength: 4,
              )),
            )));
  }

  Widget contentStory(pageIndex, storyIndex, StoryController storyController) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                ImageAssets.imgTet,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 40, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin:const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            Image.asset(ImageAssets.imgMeo, fit: BoxFit.cover)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    constraints: const BoxConstraints(
                      maxWidth: 100,
                    ),
                    child: const Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Duy Khang",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "10 phút trước",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(IconsAssets.icPublicMode,
                      width: 11, height: 11, color: Colors.white)
                ],
              ),
            ),
            Positioned(
              left: 20.0,
              //xPosition,
              top:  120.0,
              //yPosition,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Index of PageView: $pageIndex Index of story: $storyIndex",
                    style: const TextStyle(
                        color: Colors.white,
                        //color: Color(int.parse(colorValue)),
                        //fontSize: 14 * scale,
                        fontSize: 14,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ));
  }
}
