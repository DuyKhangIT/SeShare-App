import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_view.dart';
import 'package:instagram_app/page/main/post_screen/post_view.dart';

import '../main/home_screen/home_view.dart';
import '../main/profile_screen/profile_screen.dart';
import '../main/search_screen/search_screen_view.dart';
import 'navigation_bar_controller.dart';

class NavigationBarView extends StatefulWidget {
  int currentIndex = 0;
  NavigationBarView({Key? key,required this.currentIndex}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

const moonIcon = CupertinoIcons.moon_stars;

class _NavigationBarViewState extends State<NavigationBarView> {
  NavigationBarController? navigationBarController;
  List page = [
    const Home(),
    const ChatListScreen(),
    const PostScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
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
                    page[widget.currentIndex],
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        child: Container(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          height: (60),
                          child: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            currentIndex: widget.currentIndex,
                            onTap: _onItemTapped,
                            showUnselectedLabels: false,
                            showSelectedLabels: false,
                            selectedItemColor: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            elevation: 0,
                            items: [
                              BottomNavigationBarItem(
                                activeIcon: Image.asset(
                                    IconsAssets.icHomeActive,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                icon: Image.asset(IconsAssets.icHome,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                label: '',
                              ),
                              BottomNavigationBarItem(
                                activeIcon: Image.asset(
                                    IconsAssets.icChatActive,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                icon: Image.asset(IconsAssets.icChat,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.8)),
                                label: '',
                              ),
                              const BottomNavigationBarItem(
                                icon: Text(""),
                                label: '',
                              ),
                              BottomNavigationBarItem(
                                activeIcon: Image.asset(
                                    IconsAssets.icSearchActive,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                icon: Image.asset(IconsAssets.icSearch,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                label: '',
                              ),
                              BottomNavigationBarItem(
                                activeIcon: Image.asset(
                                    IconsAssets.icProfileActive,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                                icon: Image.asset(
                                    IconsAssets.icProfile,
                                    color: Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
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
                            margin: const EdgeInsets.only(bottom: 33),
                            alignment: Alignment.center,
                            width: 55,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF8c52ff),
                                    Color(0xFF5ce1e6)
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3), // Độ dịch chuyển theo trục x và y của đổ bóng
                                  ),
                                ]),
                            child: GestureDetector(
                              onTap: () {
                                _onItemTapped(2);
                              },
                              child: const Text(
                                "S",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                  ],
                ),
              ),
            ));
  }
}
