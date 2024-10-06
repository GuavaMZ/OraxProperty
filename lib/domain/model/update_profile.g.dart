// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileModel _$UpdateProfileModelFromJson(Map<String, dynamic> json) =>
    UpdateProfileModel(
      uid: json['uid'] as String,
      full_name: json['full_name'] as String,
      email: json['email'] as String,
      phone_number: json['phone_number'] as String,
      brief: json['brief'] as String,
      membership_type: json['membership_type'] as String,
    );

Map<String, dynamic> _$UpdateProfileModelToJson(UpdateProfileModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'full_name': instance.full_name,
      'email': instance.email,
      'phone_number': instance.phone_number,
      'brief': instance.brief,
      'membership_type': instance.membership_type,
    };
