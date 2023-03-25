import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/models/story_data.dart';

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
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'SeShare',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).textTheme.headline6?.color,
                        fontSize: 22,
                        fontStyle: FontStyle.italic),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        ThemeService().changeTheme();
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(right: 20),
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
                        Get.to(() => Login());
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(right: 20),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(IconsAssets.icMessage),
                        ),
                      ),
                    )
                  ],
                  elevation: 0,
                ),
                body: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        color: Colors.transparent,
                      ),
                      child: listViewStory(homeController),
                    ),
                  ],
                ),
              ),
            ));
  }

  /// list view
  Widget listViewStory(HomeController homeController) {
    homeController = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3, //Call API
          itemBuilder: (context, index) {
            return contentListViewStory();
          }),
    );
  }

  /// content list view
  Widget contentListViewStory() {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(top: 8, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.redAccent,
                  width: 3.0,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  ImageAssets.imgTest,
                  fit: BoxFit.cover,
                ),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Duy Khang",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 14, fontFamily: 'Nunito Sans')),
          ),
        ],
      ),
    );
  }
}
