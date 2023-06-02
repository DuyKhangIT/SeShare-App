import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


import '../../../../models/message/message.dart';
import '../../../../util/global.dart';
class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isTyping = false;
  late IO.Socket socket;
  List<MessageModel> listMessage=[];
  String roomId = "";

  @override
  void onReady() {
    super.onReady();
    connectAndListen();
    update();
    messageController.addListener(onTextTyping);
  }

  @override
  void onClose() {
    socket.onDisconnect((_) => debugPrint('disconnect'));
    super.onClose();
  }

  void onTextTyping() {
    if (!isTyping && messageController.text.isNotEmpty) {
      isTyping = true;
      update();
      return;
    }

    if (isTyping && messageController.text.isEmpty) {
      isTyping = false;
      update();
    }
  }

  void sendMessage(String senderName,var message, String roomId) {
    // Gửi tin nhắn từ user tới server
    socket.emit('seshare chat', {
      'senderId': senderName,
      'message': message,
      'roomId': roomId,
    });
    messageController.clear();
  }

  void connectAndListen(){
    debugPrint('-------------Call function-----------------');
    socket = IO.io('http://14.225.204.248:8080',IO.OptionBuilder()
        .setTransports(['websocket']).build());

    socket.onConnect((_) {
      debugPrint('Connect successfully');
    });

    socket.on('connect', (_) {
      debugPrint('Login to server');
      // Gửi sự kiện đăng nhập khi kết nối thành công
      socket.emit('login', {'userId': Global.userProfileResponse!.id});
    });

    socket.on('seshare chat', (data) {
      debugPrint('Received message: $data');
      listMessage.add(MessageModel(data['senderId'], data['message'],data['timeSend']));
      update();
    });

  }
}