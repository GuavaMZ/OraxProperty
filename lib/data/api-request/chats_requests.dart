import 'package:oraxproperty/domain/model/chat_message.dart';
import 'package:oraxproperty/main.dart';

class ChatsRequests {
  getUserChats() {
    // ChatsModel chatsModel;
    try {
      var chats = supabase
          .rpc('getuserchats',
              params: {'userid': supabase.auth.currentUser!.id})
          .select()
          .asStream();
      // chatsModel = ChatsModel.fromJson(chats);
      // print(chatsModel);
      return chats;
    } catch (e) {
      return e;
    }
  }

  getChatMessages(int chatId) {
    try {
      var res = supabase
          .from('messages')
          .stream(primaryKey: ['message_id'])
          .eq('chat_id', chatId)
          .order('created_at');
      return res;
    } catch (e) {
      return e;
    }
  }

  Future sendMessage(
      int chatId, String content, String sender, bool isRead,String toUsr) async {
    try {
      Map<String, dynamic> chatMessageModel = ChatMessageModel(
              chat_id: chatId, content: content, sender: sender, isRead: isRead,to_usr: toUsr)
          .toJson();
      await supabase.from('messages').insert(chatMessageModel);
    } catch (e) {
      return e;
    }
  }
}
