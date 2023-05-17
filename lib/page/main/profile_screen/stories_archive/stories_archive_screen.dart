import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/stories_archive/stories_archive_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/module.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import '../../home_screen/story_page/story_page_view.dart';

class StoriesArchiveScreen extends StatefulWidget {
  const StoriesArchiveScreen({Key? key}) : super(key: key);

  @override
  State<StoriesArchiveScreen> createState() => _StoriesArchiveScreenState();
}

class _StoriesArchiveScreenState extends State<StoriesArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    StoriesArchiveController storiesArchiveController =
        Get.put(StoriesArchiveController());
    return GetBuilder<StoriesArchiveController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.to(() => NavigationBarView(currentIndex: 4));
                  },
                  child: Icon(Icons.arrow_back,
                      color: Theme.of(context).textTheme.headline6?.color),
                ),
                title: Text("Kho lưu trữ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito Sans',
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline6?.color,
                    )),
                elevation: 0,
              ),
              body: SafeArea(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.6, crossAxisCount: 2),
                    itemCount: storiesArchiveController.data.isNotEmpty
                        ? storiesArchiveController.data.length
                        : 6,
                    itemBuilder: (context, index) {
                      if (storiesArchiveController.isLoading == true) {
                        return skeletonContentGridView();
                      } else {
                        if (storiesArchiveController.data.isNotEmpty) {
                          return contentGridView(
                              storiesArchiveController, index);
                        } else {
                          return Container();
                        }
                      }
                    }),
              )),
            ));
  }

  Widget contentGridView(
      StoriesArchiveController storiesArchiveController, index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoryPage(index: index, isStoriesArchive: true));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            /// photo
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.all(2),
                child: getNetworkImage(
                  storiesArchiveController.data[index].photoPath,
                )),

            /// upload time
            Container(
                width: 70,
                height: 46,
                margin: const EdgeInsets.only(top: 30, left: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: formatDD(
                              storiesArchiveController.data[index].createAt),
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text:
                              "\nTháng ${formatMM(storiesArchiveController.data[index].createAt)}",
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              color: Colors.black))
                    ]))),
          ],
        ),
      ),
    );
  }

  Widget skeletonContentGridView() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          /// photo
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.all(2),
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
