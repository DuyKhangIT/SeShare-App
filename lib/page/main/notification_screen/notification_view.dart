import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';

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
              icon: Icon(Icons.arrow_back,color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,),
              onPressed: () => Navigator.of(context).pop(),
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
              body: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) =>
                      contentNotificationWithAddFriend()),
            ));
  }

  Widget contentNotification() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                ImageAssets.imgTet,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            "Ken đã thích bài của bạn.",
            style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  ImageAssets.imgTet,
                  fit: BoxFit.cover,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentNotificationWithAddFriend() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                ImageAssets.imgTet,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            //"Vũ đã bắt đầu theo dõi bạn."
            "An đã theo dõi lại bạn"
            ,
            style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          /// other user accept follow of you
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 90,
                height: 28,
                alignment: Alignment.center,
                decoration:  BoxDecoration(
                  color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Text(
                  "Nhắn tin",
                    style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.bold)
                )
              ),
            ),
          ),
          /// have a user follow you
          // Expanded(
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: Container(
          //         width: 90,
          //         height: 28,
          //         alignment: Alignment.center,
          //         decoration:  BoxDecoration(
          //             color: Colors.blue,
          //             border: Border.all(color: Colors.blue.withOpacity(0.4)),
          //             borderRadius: BorderRadius.circular(5)
          //         ),
          //         child: const Text(
          //             "Theo dõi",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontFamily: 'Nunito Sans',
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.bold)
          //         )
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
