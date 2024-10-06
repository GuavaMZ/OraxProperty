// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'support_data.g.dart';

@JsonSerializable()
class SupportersModel {
  SupportersModel({required this.supporters});

  final List<SupportersData> supporters;

  factory SupportersModel.fromJson(var json) => _$SupportersModelFromJson(json);
  Map<String, dynamic> toJson() => _$SupportersModelToJson(this);
}

@JsonSerializable()
class SupportersData {
  SupportersData({required this.id,required this.created_at,required this.name, required this.phone_number});

  final int id;
  final String created_at;
  final String name;
  final String phone_number;

  factory SupportersData.fromJson(var json) => _$SupportersDataFromJson(json);
  Map<String, dynamic> toJson() => _$SupportersDataToJson(this);
}
