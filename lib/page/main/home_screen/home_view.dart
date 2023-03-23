import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_app/assets/assets.dart';

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
                      height: 98,
                      color: Colors.red,
                      child: girdViewStory(),
                    ),
                  ],
                ),
              ),
            ));
  }

  /// grid view
  Widget girdViewStory(){
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1),
        itemCount: 6, //Call API
        itemBuilder: (context, index) {
          return contentGridViewStory();
        });
  }
  /// content grid view
  Widget contentGridViewStory(){
    return  Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.fromLTRB(10,5,10,5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        child: ClipOval(
          child: Center(child: Text("avatar")),
        ));
  }
}
