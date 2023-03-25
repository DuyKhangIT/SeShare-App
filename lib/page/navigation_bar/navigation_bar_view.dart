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
    const SearchScreen(),
    const PostScreen(),
    const NotificationScreen(),
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
                body: page[currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                  unselectedItemColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white54
                          : Colors.black.withOpacity(0.4),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  elevation: 0,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 25.0),
                      label: '',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.search, size: 25.0),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(IconsAssets.icPost,
                          width: 25,
                          height: 25,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                      label: '',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.heart, size: 25.0),
                      label: '',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_outlined, size: 25.0),
                      label: '',
                    ),
                  ],
                  currentIndex: currentIndex,
                  onTap: _onItemTapped,
                ),
              ),
            ));
  }
}
