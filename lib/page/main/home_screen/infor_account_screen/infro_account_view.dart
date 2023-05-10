import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';

import '../../../../util/global.dart';
import '../../../../util/module.dart';
import '../../../navigation_bar/navigation_bar_view.dart';
import 'infor_account_controller.dart';

class InForAccountScreen extends StatefulWidget {
  const InForAccountScreen({Key? key}) : super(key: key);

  @override
  State<InForAccountScreen> createState() => _InForAccountScreenState();
}

class _InForAccountScreenState extends State<InForAccountScreen> {
  @override
  Widget build(BuildContext context) {
    InForAccountController inForAccountController =
        Get.put(InForAccountController());
    return GetBuilder<InForAccountController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    Get.to(() => NavigationBarView(
                          currentIndex: 0,
                        ));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                title: Text(
                  "Giới thiệu về tài khoản này",
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                elevation: 0,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///avatar
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Global
                                .userInfoResponseFromListPost!.avatar.isNotEmpty
                            ? SizedBox(
                              width: 70,
                              height: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child:
                                  getNetworkImage(
                                      Global
                                          .userInfoResponseFromListPost!.avatar,
                                      width: null,
                                      height: null)
                                  ),
                            )
                            : Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white),
                              ),
                      ),
                      // full name
                      Text(Global.userInfoResponseFromListPost!.fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Nunito Sans')),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          "Để góp phần xây dựng một cộng đồng trung thực, chúng tôi hiển thị thông tin về các tài khoản trên SeShare",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            height: 1.5,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(IconsAssets.icCalendar,color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? Colors.white
                                : Colors.black),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Ngày tham gia",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans')),
                                Text("Tháng 4 2023",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Nunito Sans')),
                              ],
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(IconsAssets.icLocationAccount,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Vị trí tài khoản",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans')),
                                Text(Global.userLocationFromListPost,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Nunito Sans')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
