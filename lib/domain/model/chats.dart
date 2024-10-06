import 'package:json_annotation/json_annotation.dart';
part 'chats.g.dart';

@JsonSerializable()
class ChatsModel {
  ChatsModel({required this.chats});

  var chats;

  factory ChatsModel.fromJson(var json) =>
      _$ChatsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsModelToJson(this);
}