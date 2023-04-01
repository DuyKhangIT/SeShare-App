import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/post_screen/post_view.dart';

import '../main/home_screen/home_view.dart';
import '../main/notification_screen/notification_view.dart';
import '../main/profile_screen/profile_screen_view.dart';
import '../main/search_screen/search_screen_view.dart';
import 'navigation_bar_controller.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({Key? key}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _NavigationBarViewState extends State<NavigationBarView> {
  int currentIndex = 0;

  List page = [
    const Home(),
    const NotificationScreen(),
    const PostScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    NavigationBarController navigationBarController =
    Get.put(NavigationBarController());
    return GetBuilder<NavigationBarController>(
        builder: (controller) => SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                page[currentIndex],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft:Radius.circular(30)
                    ),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      height: (60),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: currentIndex,
                        onTap: _onItemTapped,
                        showUnselectedLabels: false,
                        showSelectedLabels: false,
                        elevation: 0,
                        items: [
                          BottomNavigationBarItem(
                            activeIcon: Image.asset(IconsAssets.icHomeActive,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            icon: Image.asset(IconsAssets.icHome,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: Image.asset(IconsAssets.icNotificationActive,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            icon: Image.asset(IconsAssets.icNotification,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.8)),
                            label: '',
                          ),
                          const BottomNavigationBarItem(
                            icon: Text(""),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            activeIcon: Image.asset(IconsAssets.icSearchActive,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            icon: Image.asset(IconsAssets.icSearch,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            label: '',
                          ),

                          BottomNavigationBarItem(
                            activeIcon: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    ImageAssets.imgTet,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            icon: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    ImageAssets.imgTet,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            label: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: const EdgeInsets.only(bottom: (30)),
                        width: (60),
                        height: (60),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.blueAccent.withOpacity(0.9),
                                  Colors.blue,
                                  Colors.purple.withOpacity(0.9),
                                ]
                            )
                        ),
                        child: IconButton(
                            onPressed: () {
                              _onItemTapped(2);
                            },
                            icon: Image.asset(IconsAssets.icPost,
                                color: Colors.white),))),
              ],
            ),
          ),
        ));
  }
}
