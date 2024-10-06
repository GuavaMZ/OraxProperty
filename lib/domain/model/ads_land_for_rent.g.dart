// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_land_for_rent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandForRentModel _$LandForRentModelFromJson(Map<String, dynamic> json) =>
    LandForRentModel(
      uid: json['uid'] as String,
      category_id: (json['category_id'] as num).toInt(),
      price: json['price'] as String,
      area: json['area'] as String,
      landType: json['type'] as String,
      description: json['description'] as String,
      location_latlng: json['location_latlng'] as String,
      location_address: json['location_address'] as String,
      country: (json['country'] as num).toInt(),
      street_width: json['street_width'] as String,
    );

Map<String, dynamic> _$LandForRentModelToJson(LandForRentModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'category_id': instance.category_id,
      'price': instance.price,
      'area': instance.area,
      'type': instance.landType,
      'description': instance.description,
      'location_latlng': instance.location_latlng,
      'location_address': instance.location_address,
      'country': instance.country,
      'street_width':instance.street_width
    };
