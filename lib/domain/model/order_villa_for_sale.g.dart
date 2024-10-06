// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_villa_for_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVillaForSaleModel _$OrderVillaForSaleModelFromJson(
        Map<String, dynamic> json) =>
    OrderVillaForSaleModel(
      uid: json['uid'] as String,
      category_id: (json['category_id'] as num).toInt(),
      bedrooms: json['bedrooms'] as String,
      livingrooms: json['livingrooms'] as String,
      bathrooms: json['bathrooms'] as String,
      property_age: json['property_age'] as String,
      has_car_entrance: json['has_car_entrance'] as bool,
      price: json['price'] as String,
      area: json['area'] as String,
      is_furnished: json['is_furnished'] as bool,
      apartments: json['apartments'] as String,
      street_width: json['street_width'] as String,
      has_driver_room: json['has_driver_room'] as bool,
      has_kitchen: json['has_kitchen'] as bool,
      is_duplex: json['is_duplex'] as bool,
      has_basement: json['has_basement'] as bool,
      with_stairs: json['with_stairs'] as bool,
      has_maid_room: json['has_maid_room'] as bool,
      has_pool: json['has_pool'] as bool,
      description: json['description'] as String,
      location_address: json['location_address'] as String,
      location_latlng: json['location_latlng'] as String,
      country: (json['country'] as num).toInt(),
    );

Map<String, dynamic> _$OrderVillaForSaleModelToJson(
        OrderVillaForSaleModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'category_id': instance.category_id,
      'bedrooms': instance.bedrooms,
      'livingrooms': instance.livingrooms,
      'bathrooms': instance.bathrooms,
      'property_age': instance.property_age,
      'has_car_entrance': instance.has_car_entrance,
      'price': instance.price,
      'area': instance.area,
      'is_furnished': instance.is_furnished,
      'apartments': instance.apartments,
      'street_width': instance.street_width,
      'has_driver_room': instance.has_driver_room,
      'has_kitchen': instance.has_kitchen,
      'is_duplex': instance.is_duplex,
      'has_basement': instance.has_basement,
      'with_stairs': instance.with_stairs,
      'has_maid_room': instance.has_maid_room,
      'has_pool': instance.has_pool,
      'description': instance.description,
      'location_address': instance.location_address,
      'location_latlng': instance.location_latlng,
      'country': instance.country,
    };
