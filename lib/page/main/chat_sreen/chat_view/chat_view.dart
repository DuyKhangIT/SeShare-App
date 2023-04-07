import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:instagram_app/assets/assets.dart';
import 'package:instagram_app/page/main/chat_sreen/chat_list/chat_list_view.dart';
import 'package:instagram_app/page/navigation_bar/navigation_bar_view.dart';
import 'package:instagram_app/widget/avatar_circle.dart';

import '../../../../widget/dashed_line.dart';
import 'chat_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        builder: (controller) => Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white,
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        titleHeader(context),
                        messageList(),
                      ],
                    ),
                  ),
                  inputMessageTextfield(),
                ],
              )),
            ));
  }

  Widget titleHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => NavigationBarView());
                },
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    )),
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 20, right: 10),
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
              const Text(
                "Duy Khang",
                style: TextStyle(
                  fontSize: (16),
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          CustomPaint(
            size: const Size(double.infinity, 0),
            painter: DashedLinePainter(
              dashLenght: 6,
              dashSpace: 4,
              strokeWidth: 1,
              color: Colors.black,
              isHorizontal: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget messageList() {
    return Expanded(
      child: ListView.builder(
        controller: chatController.scrollController,
        padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
        itemCount: 2,
        itemBuilder: ((context, index) {
          return receivedMessage();
        }),
      ),
    );
  }

  Widget sentMessage() {
    //DateTime date = DateTime.fromMillisecondsSinceEpoch(message.mTime);
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.centerRight,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        alignment: Alignment.centerRight,
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
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF8c52ff),
                      Colors.lightBlueAccent
                    ],
                  )),
              child: const Text(
                "Xin chào bạn, Hôm nay bạn thế nào Hôm nay bạn thế nào",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              constraints: const BoxConstraints(
                maxWidth: 240
              ),
              alignment: Alignment.centerRight,
              child: const Text(
                "12:00",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedMessage() {
    //DateTime date = DateTime.fromMillisecondsSinceEpoch(message.mTime);

    return FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(ImageAssets.imgTest,width: 40,height: 40,fit: BoxFit.cover,),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey.withOpacity(0.4)
                        ),
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
                    constraints: const BoxConstraints(
                        maxWidth: 240
                    ),
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
      ),
    );
  }

  Widget inputMessageTextfield() {
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
                    controller: chatController.messageController,
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
                  onTap: (){},
                  child: Icon(
                    Icons.send_rounded,
                    color: chatController.isTyping
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
