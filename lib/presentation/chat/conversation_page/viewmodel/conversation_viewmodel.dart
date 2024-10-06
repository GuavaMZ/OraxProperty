import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oraxproperty/data/api-request/chats_requests.dart';

class ConversationViewModel extends ChangeNotifier {
  TextEditingController messageTextController = TextEditingController();

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  getMessages(int chatId) {
    ChatsRequests chatsRequests = ChatsRequests();
    try {
      var res = chatsRequests.getChatMessages(chatId);
      notifyListeners();
      return res;
    } catch (e) {
      return e;
    }
  }

  sendMessage(int chatId, String content, String sender, bool isRead,String toUsr) async {
    ChatsRequests chatsRequests = ChatsRequests();
    try {
      await chatsRequests.sendMessage(chatId, content, sender, isRead, toUsr);
    } catch (e) {
      return e;
    }
  }

}
