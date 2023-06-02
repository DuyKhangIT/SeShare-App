import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_controller.dart';
import 'package:instagram_app/util/module.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../models/create_chat/create_chat_request.dart';
import '../../../../util/global.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    ChatListController chatListController = Get.put(ChatListController());
    return GetBuilder<ChatListController>(
        builder: (controller) => Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBox(chatListController, context),
                    Expanded(
                      child: RefreshIndicator(
                        edgeOffset: 0,
                        displacement: 10,
                        onRefresh: chatListController.pullToRefreshData,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          scrollDirection: Axis.vertical,
                          itemCount: chatListController.isLoading == true
                              ? 5
                              : chatListController.result.length,
                          itemBuilder: (context, index) {
                            if (chatListController.isLoading == true) {
                              return skeletonContentListChat();
                            } else {
                              if (chatListController.result.isEmpty) {
                                return Container();
                              } else {
                                return contentListChat(
                                    chatListController, index);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget contentListChat(ChatListController chatListController, index) {
    return GestureDetector(
      onTap: () {
        if (Global.isAvailableToClick()) {
          Global.userInfoListChatResponse = chatListController.result[index].userInfoListChatResponse;
          CreateChatRequest createChatRequest = CreateChatRequest(
              chatListController.result[index].userInfoListChatResponse!.id);
          chatListController.createChat(createChatRequest);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: getNetworkImage(chatListController
                        .result[index]
                        .userInfoListChatResponse!.avatar,width: 45,height: 45))),
            Container(
              width: MediaQuery.of(context).size.width / 1.35,
              height: 35,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                        chatListController.result[index]
                            .userInfoListChatResponse!.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: const Text("Tin nhắn",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, fontFamily: 'Nunito Sans')),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget skeletonContentListChat() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.4),
            highlightColor: Colors.grey.withOpacity(0.8),
            child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12))),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.35,
            height: 35,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.withOpacity(0.8),
                  child: Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5))),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.withOpacity(0.8),
                  child: Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// search box
  Widget searchBox(
      ChatListController chatListController, BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.blueGrey.withOpacity(0.2),
      ),
      child: TextField(
        controller: chatListController.searchController,
        cursorColor: Colors.black,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w400,
            fontSize: 14),
        onChanged: (value) {
          setState(() {
            chatListController.updateSearch(value);
            chatListController.update();
          });
        },
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: (chatListController.searchController.text.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      child: Image.asset(
                        IconsAssets.icClearText,
                        width: 10,
                        height: 10,
                      ),
                      onTap: () {
                        chatListController.clearTextSearch();
                        //_controller.updateSearch("");
                      },
                    ),
                  )
                : null,
            hintText: 'Tìm kiếm...',
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.2),
                fontFamily: 'NunitoSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            border: InputBorder.none),
      ),
    );
  }
}
