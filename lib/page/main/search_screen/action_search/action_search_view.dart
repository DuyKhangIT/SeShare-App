import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/search_screen/search_screen_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/global.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import 'action_search_controller.dart';

class ActionSearchScreen extends StatefulWidget {
  const ActionSearchScreen({Key? key}) : super(key: key);

  @override
  State<ActionSearchScreen> createState() => _ActionSearchScreenState();
}

class _ActionSearchScreenState extends State<ActionSearchScreen> {
  @override
  Widget build(BuildContext context) {
    ActionSearchController actionSearchController =
        Get.put(ActionSearchController());
    return GetBuilder<ActionSearchController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                body: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(() => NavigationBarView(currentIndex: 3));
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              _searchBox(actionSearchController)
                            ],
                          )),
                      Expanded(
                        child: ListView.builder(
                            itemCount: actionSearchController.result.length,
                            itemBuilder: (context, index) {
                              return contentListView(
                                  actionSearchController, index);
                              //return skeletonContentListView();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  /// search box
  Widget _searchBox(ActionSearchController controller) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.25,
      height: 45,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.blueGrey.withOpacity(0.15),
      ),
      child: TextField(
        controller: controller.searchController,
        cursorColor: Colors.black,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14),
        onChanged: (value) {
          setState(() {
            controller.updateSearch(value);
            controller.update();
          });
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: (controller.searchController.text.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Image.asset(
                        IconsAssets.icClearText,
                        width: 10,
                        height: 10,
                      ),
                      onTap: () {
                        controller.clearTextSearch();
                        //_controller.updateSearch("");
                      },
                    ),
                  )
                : null,
            hintText: 'Tìm kiếm...',
            hintStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito Sans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            border: InputBorder.none),
      ),
    );
  }

  Widget contentListView(ActionSearchController actionSearchController, index) {
    return GestureDetector(
      onTap: (){
        if (actionSearchController.result[index].id !=
            Global.userProfileResponse!.id) {
          actionSearchController.userIdForLoadListAnotherProfile =
              actionSearchController.result[index].id;
          actionSearchController.loadListPhotoAnotherUser();
        } else {
          Get.offAll(() => NavigationBarView(currentIndex: 4));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 20, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// avatar user
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(Global.convertMedia(
                      actionSearchController.result[index].avatar, null, null),fit: BoxFit.cover)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// full name
                  Text( actionSearchController.result[index].fullName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.bold)),

                  /// bio
                  Text(actionSearchController.result[index].bio,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget skeletonContentListView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// avatar user
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            margin: const EdgeInsets.only(right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// full name
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.withOpacity(0.8),
                  child: Container(
                    width: 120,
                    height: 20,
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                ),

                /// bio
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.withOpacity(0.8),
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
