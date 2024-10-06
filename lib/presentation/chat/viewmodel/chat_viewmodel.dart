import 'package:flutter/material.dart';
import 'package:oraxproperty/data/api-request/chats_requests.dart';

class ChatViewModel extends ChangeNotifier {
  getUserChats()  {
    ChatsRequests chatsRequests = ChatsRequests();
    try {
      var res = chatsRequests.getUserChats();
      return res;
    } catch (e) {
      return e;
    }
  }
}
