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
import '../../../util/global.dart';
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
              child: Material(
                key: UniqueKey(),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black54
                      : Colors.blueGrey.withOpacity(0.3),
                  child: CustomScrollView(
                    controller: homeController.scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black54
                            : Colors.white,
                        automaticallyImplyLeading: false,
                        title: Text(
                          'Trang chủ',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.color,
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
                                  Theme.of(context).brightness ==
                                          Brightness.dark
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
                          ),
                        ],
                        elevation: 0,
                      ),
                      //////////// list story  ////////////////
                      SliverToBoxAdapter(
                        child: Container(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.white,
                          height: 100, // set height of the container to hold the stories
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return contentListViewStoryFirstIndex();
                              } else {
                                return contentListViewStory();
                              }
                            },
                          ),
                        ),
                      ),
                      //////////// list post  ////////////////
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return contentListViewPost();
                          },
                          childCount: homeController.currentMax,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 70), // add bottom padding here
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  /// content list view story
  Widget contentListViewStory() {
    return GestureDetector(
      onTap: (){
        Get.to(() => StoryPage());
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarStory(
              image: ImageAssets.imgTet,
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text("Duy Khang",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
            ),
          ],
        ),
      ),
    );
  }

  /// content list view story index == 0
  Widget contentListViewStoryFirstIndex() {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            margin: const EdgeInsets.only(top: 8, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
            ),
            child: Image.asset(IconsAssets.icPost),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Tin của bạn",
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
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 25, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// avatar + username + location
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///avatar
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child:
                        Image.asset(
                          ImageAssets.imgTet,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),

                    /// user name and location
                    Container(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          const Text("Duy Khang",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans')),
                          const SizedBox(height: 4),
                          Text(Global.currentLocation,
                              maxLines: 2,
                              style: const TextStyle(
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
          (Global.checkIn != null && Global.checkIn.isNotEmpty)
          ? Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,10),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(IconsAssets.icLocationPost,width: 30,height: 30,),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.4,
                  height: 40,
                  child: Text("Địa điểm bạn nhắc tới: ${Global.checkIn}",
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Nunito Sans')),
                ),
              ],
            ),
          ) : Container(),
          /// image post
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Image.asset(ImageAssets.imgTet))),

          /// icon like + cmt
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// viewer and cmter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.color,
                                fontFamily: 'NunitoSans'),
                            children: const [
                              TextSpan(
                                  text: "100K ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NunitoSans')),
                              TextSpan(
                                  text: "Đã Thích",
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'NunitoSans')),
                            ]),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.color,
                                fontFamily: 'NunitoSans'),
                            children: const [
                              TextSpan(
                                  text: "100K ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NunitoSans')),
                              TextSpan(
                                  text: "Đã Bình Luận",
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'NunitoSans')),
                            ]),
                      ),
                    ],
                  ),
                ),

                /// icon like + cmt
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// ic like
                    GestureDetector(
                      onTap: () {
                        homeController.isLike = !homeController.isLike;
                        homeController.update();
                      },
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 80),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (homeController.isLike == true)
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.red
                                            : Colors.red,
                                        BlendMode.srcIn,
                                      ),
                                      child: Image.asset(IconsAssets.icLikeRed),
                                    )
                                  : ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                        BlendMode.srcIn,
                                      ),
                                      child: Image.asset(IconsAssets.icLike),
                                    ),
                              const SizedBox(width: 10),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 45),
                                child: Text("Thích",
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
                          )),
                    ),

                    /// ic cmt
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet<dynamic>(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12))),
                            context: context,
                            builder: (context) {
                              return dialogCmt();
                            });
                      },
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 105),
                        padding: const EdgeInsets.all(5),
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
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              constraints: const BoxConstraints(maxWidth: 60),
                              child: Text(
                                "Bình Luận",
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
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// descriptions of post
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
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
                        text:
                            "Đi Vũng Tàu xả stress",
                        style: TextStyle(fontSize: 14)),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogCmt(){
    return SafeArea(
      child: Container(
        color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: GestureDetector (
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.transparent,
                  )),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                return contentListCmt();
              }),
            )
          ],
      ),
        ),
    );
  }

  Widget contentListCmt() {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12,left: 10,right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(ImageAssets.imgTest,width: 40,height: 40,fit: BoxFit.cover,),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.withOpacity(0.4)
                  ),
                  child: Text(
                    "Hôm nay rất tuyệt Hôm nay rất tuyệt Hôm nay rất tuyệt",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  constraints: const BoxConstraints(
                      maxWidth: 240
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "12:00",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
