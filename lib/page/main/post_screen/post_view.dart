import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/post_screen/post_controller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    return GetBuilder<PostController>(
        builder: (controller) => SafeArea(
                child: Scaffold(
              body: Center(
                child: Text("Post Screen"),
              ),
            )));
  }
}
