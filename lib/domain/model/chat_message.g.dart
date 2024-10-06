// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      chat_id: (json['chat_id'] as num).toInt(),
      content: json['content'] as String,
      sender: json['sender'] as String,
      isRead: json['isRead'] as bool,
      to_usr: json['to_usr'] as String,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'chat_id': instance.chat_id,
      'content': instance.content,
      'sender': instance.sender,
      'isRead': instance.isRead,
      'to_usr': instance.to_usr,
    };
