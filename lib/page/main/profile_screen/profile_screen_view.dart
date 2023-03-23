import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/profile_screen/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return
      GetBuilder<ProfileController>(builder: (controller)=> Center(
          child: Text('Profile Screen'))
    );
  }
}
