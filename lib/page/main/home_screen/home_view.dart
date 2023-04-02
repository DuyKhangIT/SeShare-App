import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/story_data.dart';
import 'package:instagram_app/page/main/home_screen/story_page/story_page_view.dart';
import 'package:instagram_app/page/main/notification_screen/notification_view.dart';
import 'package:instagram_app/widget/avatar_circle.dart';

import '../../../assets/icons_assets.dart';
import '../../../config/theme_service.dart';
import '../../onboarding/login/login_view.dart';
import 'home_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return GetBuilder<HomeController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.grey.withOpacity(0.4),
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    'Trang chủ',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).textTheme.headline6?.color,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  actions: [
                    GestureDetector(
                      onTap: () {
                        ThemeService().changeTheme();
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(right: 10),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: const Icon(
                            moonIcon,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // homeController.auth.signOut();
                        // ConfigSharedPreferences().setStringValue(
                        //     SharedData.USER_ID.toString(), "");
                        Get.to(() => NotificationScreen());
                      },
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(IconsAssets.icNotification),
                      ),
                    )
                  ],
                  elevation: 0,
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height:100,child: listViewStory(homeController)),
                      Expanded(child: listViewPost())
                    ],
                ),
              ),
            ));
  }

  /// list view story
  Widget listViewStory(HomeController homeController) {
    homeController = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10, //Call API
          itemBuilder: (context, index) {
            return contentListViewStory();
          }),
    );
  }

  /// list view story
  Widget listViewPost() {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        scrollDirection: Axis.vertical,
        itemCount: 2, //Call API
        itemBuilder: (context, index) {
          return contentListViewPost();
        });
  }

  /// content list view story
  Widget contentListViewStory() {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarStory(image: ImageAssets.imgTet,onTap: (){},),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Duy Khang",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
          ),
        ],
      ),
    );
  }

  /// content list view post
  Widget contentListViewPost() {
    HomeController homeController = Get.put(HomeController());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white.withOpacity(0.7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// avatar + username + location
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///avatar
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          ImageAssets.imgTet,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// user name and location
                    SizedBox(
                      width: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Duy Khang",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans')),
                          Text("Tp.Hồ Chí Minh",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Nunito Sans')),
                        ],
                      ),
                    ),
                  ],
                ),

                /// dot
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(IconsAssets.icDot),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Image.asset(ImageAssets.imgTet))),

          /// icon like + cmt
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 210),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// ic like
                      GestureDetector(
                        onTap: (){
                          homeController.isLike = !homeController.isLike;
                          homeController.update();
                        },
                        child:
                        homeController.isLike == true
                            ?Container(
                          constraints: const BoxConstraints(maxWidth: 80),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Row(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.red
                                      : Colors.red,
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(IconsAssets.icLikeRed),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 45),
                                child: Text("100K",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )
                            :Container(
                          constraints: const BoxConstraints(maxWidth: 80),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.withOpacity(0.2)
                          ),
                          child: Row(
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(IconsAssets.icLike),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 45),
                                child: Text("100K",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// ic cmt
                      Container(
                        constraints: BoxConstraints(maxWidth: 90),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.2)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(IconsAssets.icComment),
                            ),
                            SizedBox(width: 10),
                            Container(
                              constraints: BoxConstraints(maxWidth: 45),
                              child: Text(
                                "100K",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// descriptions of post
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 25),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline6?.color,
                      fontFamily: 'NunitoSans'),
                  children: const [
                    TextSpan(
                        text: "Duy Khang ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Hôm nay thật là vui!!",
                        style: TextStyle(fontSize: 14)),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
