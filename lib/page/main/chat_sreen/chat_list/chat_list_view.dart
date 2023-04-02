import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_controller.dart';

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
        builder: (controller) => SafeArea(
            child: Scaffold(
              body: Center(
                child: Text("Chat list Screen"),
              ),
            )));
  }
}