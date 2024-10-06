// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_apartment_for_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApartmentForSaleModel _$OrderApartmentForSaleModelFromJson(
        Map<String, dynamic> json) =>
    OrderApartmentForSaleModel(
      uid: json['uid'] as String,
      category_id: (json['category_id'] as num).toInt(),
      bedrooms: json['bedrooms'] as String,
      livingrooms: json['livingrooms'] as String,
      bathrooms: json['bathrooms'] as String,
      floor_number: json['floor_number'] as String,
      property_age: json['property_age'] as String,
      has_car_entrance: json['has_car_entrance'] as bool,
      has_special_roof: json['has_special_roof'] as bool,
      is_apartment_in_a_villa: json['is_apartment_in_a_villa'] as bool,
      has_double_entrance: json['has_double_entrance'] as bool,
      has_special_entrance: json['has_special_entrance'] as bool,
      price: json['price'] as String,
      area: json['area'] as String,
      description: json['description'] as String,
      location_address: json['location_address'] as String,
      location_latlng: json['location_latlng'] as String,
      country: (json['country'] as num).toInt(),
    );

Map<String, dynamic> _$OrderApartmentForSaleModelToJson(
        OrderApartmentForSaleModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'category_id': instance.category_id,
      'bedrooms': instance.bedrooms,
      'livingrooms': instance.livingrooms,
      'bathrooms': instance.bathrooms,
      'floor_number': instance.floor_number,
      'property_age': instance.property_age,
      'has_car_entrance': instance.has_car_entrance,
      'has_special_roof': instance.has_special_roof,
      'is_apartment_in_a_villa': instance.is_apartment_in_a_villa,
      'has_double_entrance': instance.has_double_entrance,
      'has_special_entrance': instance.has_special_entrance,
      'price': instance.price,
      'area': instance.area,
      'description': instance.description,
      'location_address': instance.location_address,
      'location_latlng': instance.location_latlng,
      'country': instance.country,
    };
