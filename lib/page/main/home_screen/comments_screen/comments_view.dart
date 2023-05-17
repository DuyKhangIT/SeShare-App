import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/models/add_coment_post/add_comment_post_request.dart';
import 'package:instagram_app/models/edit_comment_post/edit_comment_post_request.dart';
import 'package:instagram_app/page/main/home_screen/comments_screen/comments_screen_controller.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../models/delete_comment_post/delete_comment_post_request.dart';
import '../../../../util/global.dart';

class CommentScreen extends StatefulWidget {
  bool? isMyPost = false;
  CommentScreen({Key? key,this.isMyPost}) : super(key: key);

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
                leading: GestureDetector(
                    onTap: () {
                      if (Global.isAvailableToClick()) {
                        widget.isMyPost == true
                        ?commentsController.updateListMyPosts()
                        :commentsController.updateListPosts();
                      }
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
                      child: Global.dataListCmt!.comments!.isEmpty
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
                              itemCount: Global.dataListCmt!.comments!.length,
                              itemBuilder: (context, index) {
                                return contentListCmt(
                                    commentsController, index);
                              })),
                  inputMessageTextField(commentsController)
                ],
              )),
            ));
  }

  Widget contentListCmt(CommentsController commentsController, index) {
    return GestureDetector(
      onLongPress: () {
        if (Global.dataListCmt!.comments![index].isCommented == true) {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return detailBottomSheetMenuComment(commentsController, index);
              });
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Global.dataListCmt!.comments![index]
                      .userInfoCommentResponse!.avatar.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        Global.convertMedia(
                            Global.dataListCmt!.comments![index]
                                .userInfoCommentResponse!.avatar,
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
                          Global.dataListCmt!.comments![index]
                              .userInfoCommentResponse!.fullName,
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'Nunito Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(
                        Global.dataListCmt!.comments![index].commentTime,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Global.dataListCmt!.comments![index].comment,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Nunito Sans',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputMessageTextField(CommentsController commentsController) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.6)
          : Colors.white,
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
                    decoration: InputDecoration(
                      hintText: 'Nhập bình luận',
                      hintStyle: TextStyle(
                          fontFamily: 'Nunito Sans',
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 18,
                height: 48,
                child: GestureDetector(
                  onTap: () {
                    if (Global.isAvailableToClick()) {
                      AddCommentPostRequest request = AddCommentPostRequest(
                          Global.idPost, commentsController.cmtController.text);
                      commentsController.addCommentPost(request);
                    }
                  },
                  child: Icon(Icons.send_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailBottomSheetMenuComment(
      CommentsController commentsController, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.6)),
                ),

                /// edit cmt
                GestureDetector(
                  onTap: () {
                    commentsController.editCmtController.text =
                        Global.dataListCmt!.comments![index].comment;
                    commentsController.update();
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return editComment(commentsController, index);
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(IconsAssets.icEditPost),
                        const SizedBox(width: 10),
                        const Text(
                          "Chỉnh sửa",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                /// delete cmt
                GestureDetector(
                  onTap: () {
                    if (Global.isAvailableToClick()) {
                      Navigator.pop(context);
                      DeleteCommentPostRequest deleteCmtRequest =
                          DeleteCommentPostRequest(Global.dataListCmt!.postId,
                              Global.dataListCmt!.comments![index].commentId);
                      commentsController.deleteCommentPost(deleteCmtRequest);
                      commentsController.update();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(IconsAssets.icDeletePost),
                        const SizedBox(width: 10),
                        const Text(
                          "Xóa",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget editComment(CommentsController commentsController, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              )),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.1,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back)),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        alignment: Alignment.center,
                        child: const Text(
                          "Chỉnh sửa",
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Global.dataListCmt!.comments![index]
                            .userInfoCommentResponse!.avatar.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              Global.convertMedia(
                                  Global.dataListCmt!.comments![index]
                                      .userInfoCommentResponse!.avatar,
                                  50,
                                  50),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey.withOpacity(0.4),
                          ),

                    /// input new cmt
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        maxLines: null,
                        controller: commentsController.editCmtController,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          counterText: '',
                        ),
                        onChanged: (value) {
                          commentsController.isTyping = true;
                          commentsController.editCmt = value;
                          commentsController.update();
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          margin: const EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2)),
                          child: const Text(
                            "Hủy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Global.isAvailableToClick()) {
                            Navigator.pop(context);
                            EditCommentPostRequest editCmtRequest =
                                EditCommentPostRequest(
                                    Global.dataListCmt!.postId,
                                    Global.dataListCmt!.comments![index].commentId,
                                    commentsController.editCmt);
                            commentsController.editCommentPost(editCmtRequest);
                            commentsController.update();
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Text(
                            "Cập nhật",
                            style: TextStyle(
                                fontWeight: commentsController.isTyping
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }
}
