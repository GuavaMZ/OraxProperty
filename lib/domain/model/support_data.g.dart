// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportersModel _$SupportersModelFromJson(var json) =>
    SupportersModel(
      supporters: (json as List<dynamic>)
          .map(SupportersData.fromJson)
          .toList(),
    );

Map<String, dynamic> _$SupportersModelToJson(SupportersModel instance) =>
    <String, dynamic>{
      'supporters': instance.supporters,
    };

SupportersData _$SupportersDataFromJson(Map<String, dynamic> json) =>
    SupportersData(
      id: (json['id'] as num).toInt(),
      created_at: json['created_at'] as String,
      name: json['name'] as String,
      phone_number: json['phone_number'] as String,
    );

Map<String, dynamic> _$SupportersDataToJson(SupportersData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'name': instance.name,
      'phone_number': instance.phone_number,
    };
