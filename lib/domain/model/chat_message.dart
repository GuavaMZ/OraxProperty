// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessageModel {
  ChatMessageModel({
    required this.chat_id,
    required this.content,
    required this.sender,
    required this.isRead,
    required this.to_usr
  });
  int chat_id;
  String content;
  String sender;
  bool isRead;
  String to_usr;

  factory ChatMessageModel.fromJson(var json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
