import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_screen_controller.dart';

import '../../../../assets/images_assets.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    CommentsController commentsController = Get.put(CommentsController());
    return GetBuilder<CommentsController>(
        builder: (controller) => Scaffold(
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context,index){
                            return contentListCmt();
                          }
                  )),

                  inputMessageTextfield(commentsController)
                ],
              )),
            ));
  }

  Widget contentListCmt() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              ImageAssets.imgTest,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.withOpacity(0.4)),
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
                  constraints: const BoxConstraints(maxWidth: 240),
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

  Widget inputMessageTextfield(commentsController) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: TextField(
                    controller: commentsController.cmtController,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 18,
                height: 48,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.send_rounded,
                    color: commentsController.isTyping
                        ? Colors.blue[700]
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
