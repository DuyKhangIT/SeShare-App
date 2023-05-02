import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_controller.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_view/chat_view.dart';

import '../../../../assets/icons_assets.dart';
import '../../../../config/theme_service.dart';

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
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return contentListChat();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget contentListChat() {
    return GestureDetector(
      onTap: (){
        Get.to(() => const ChatView());
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
                  child: Image.asset(
                    ImageAssets.imgTet,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width / 1.35,
              height: 35,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: const Text("Khang Nguyễn",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.bold)),
                      ),
                      const Text("12:00",
                          style:
                              TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
                    ],
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: const Text("Hôm nay thế nào?",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 14, fontFamily: 'Nunito Sans')),
                  ),
                ],
              ),
            )
          ],
        ),
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
          chatListController.inputSearch = value;
          chatListController.update();

          //controller.updateSearch(value);
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
