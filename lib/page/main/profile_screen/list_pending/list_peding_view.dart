import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/profile_screen/list_pending/list_my_friend/list_my_friend_view.dart';
import 'package:instagram_app/util/module.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/global.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import 'list_pending_controller.dart';

class ListPendingScreen extends StatefulWidget {
  const ListPendingScreen({Key? key}) : super(key: key);

  @override
  State<ListPendingScreen> createState() => _ListPendingScreenState();
}

class _ListPendingScreenState extends State<ListPendingScreen> {
  @override
  Widget build(BuildContext context) {
    ListPendingController listPendingController = Get.put(ListPendingController());
    return GetBuilder<ListPendingController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.white,
                body: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  listPendingController.backAndLoadDataListFriend();
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              _searchBox(listPendingController)
                            ],
                          )),

                      GestureDetector(
                        onTap: (){
                          listPendingController.loadDataListFriend();
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 20,left: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:  const Text("Bạn bè",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w500)),

                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: listPendingController.isLoading == true
                                ? 5
                                : listPendingController.result.length,
                            itemBuilder: (context, index) {
                              if (listPendingController.isLoading) {
                                return skeletonContentListView();
                              } else {
                                return contentListView(listPendingController, index);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  /// search box
  Widget _searchBox(ListPendingController controller) {
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

  Widget contentListView(ListPendingController listPendingController, index) {
    return GestureDetector(
            onTap: () {},
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
                        child: getNetworkImage(listPendingController
                            .result[index].recipientObjectResponse!.avatar)),
                  ),

                  /// full name + bio
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// full name
                        Text(
                            listPendingController.result[index]
                                .recipientObjectResponse!.fullName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.bold)),

                        /// bio
                        Text(
                            listPendingController
                                .result[index].recipientObjectResponse!.bio,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontFamily: 'Nunito Sans'))
                      ],
                    ),
                  ),
                  Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 5, left: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(7)),
                      child: const Text(
                        "Hủy bạn bè",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Nunito Sans'),
                        textAlign: TextAlign.center,
                      ))
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
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ),

          /// full name + bio
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// full name
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.withOpacity(0.8),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 20,
                    margin: const EdgeInsets.only(bottom: 5, right: 15),
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
                    width: MediaQuery.of(context).size.width / 2,
                    height: 20,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
              width: 80,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5, left: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(7)),
            ),
          )
        ],
      ),
    );
  }
}
