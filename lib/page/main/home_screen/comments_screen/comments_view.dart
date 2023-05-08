import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_screen_controller.dart';

import '../../../../util/global.dart';

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
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).textTheme.headline6?.color,
                    )),
                title: Text("Bình luận",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).textTheme.headline6?.color,
                        fontFamily: 'Nunito Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                elevation: 0,
              ),
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: Global.dataListCmt.isEmpty
                          ? Center(
                              child: Text("Không có bình luận nào",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 13)),
                            )
                          : ListView.builder(
                              itemCount: Global.dataListCmt.length,
                              itemBuilder: (context, index) {
                                return contentListCmt(index);
                              })),
                  inputMessageTextField(commentsController)
                ],
              )),
            ));
  }

  Widget contentListCmt(index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Global.dataListCmt[index].userInfoCommentResponse!.avatar
                    .isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      Global.convertMedia(
                          Global.dataListCmt[index].userInfoCommentResponse!
                              .avatar,
                          40,
                          40),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey.withOpacity(0.4),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        Global.dataListCmt[index].userInfoCommentResponse!
                            .fullName,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontFamily: 'Nunito Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
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
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Text(
                    Global.dataListCmt[index].comment,
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

  Widget inputMessageTextField(commentsController) {
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
