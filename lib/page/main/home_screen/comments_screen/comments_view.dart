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
                          itemCount: 5,
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                ImageAssets.imgTest,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Duy Khang",style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontFamily: 'Nunito Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )),
                    const SizedBox(width: 10),
                    const Text(
                      "12:00",
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Text(
                    "Đi chơi đâu đó",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
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
                      hintText: 'Nhập bình luận',
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
