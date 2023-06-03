import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../util/module.dart';
import 'notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    Get.to(() => NavigationBarView(currentIndex: 0));
                  },
                ),
                centerTitle: true,
                title: Text(
                  'Thông báo',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RefreshIndicator(
                  edgeOffset: 0,
                  displacement: 10,
                  onRefresh: notificationController.pullToRefreshData,
                  child: ListView.builder(
                      itemCount: notificationController.isLoading
                          ? 5
                          : notificationController.data.length,
                      itemBuilder: (context, index) {
                        if (notificationController.isLoading == true) {
                          return skeletonContentNotification();
                        } else {
                          if (notificationController.data.isEmpty) {
                            return Container();
                          } else {
                            return contentNotification(
                                notificationController, index);
                          }
                        }
                      }),
                ),
              ),
            ));
  }

  Widget contentNotification(
      NotificationController notificationController, index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 45,
            height: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: getNetworkImage(
                    notificationController.data[index].whoUser!.avatar,
                    width: 45,
                    height: 45)),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.9,
            constraints: const BoxConstraints(maxHeight: 50),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              notificationController.data[index].content,
              style: const TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 65,
            height: 20,
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Text(
              maxLines: 1,
              notificationController.data[index].uploadTime,
              style: const TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget skeletonContentNotification() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
